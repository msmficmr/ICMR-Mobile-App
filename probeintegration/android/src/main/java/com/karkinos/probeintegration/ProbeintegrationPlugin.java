package com.karkinos.probeintegration;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.EventChannel;

import androidx.core.content.ContextCompat;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.hardware.usb.UsbDevice;
import android.hardware.usb.UsbDeviceConnection;
import android.hardware.usb.UsbManager;
import android.widget.Toast;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Camera;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.ImageFormat;
import android.graphics.Paint;
import android.graphics.Rect;
import android.graphics.SurfaceTexture;

import android.media.Image;
import android.media.ImageReader;
import android.media.MediaActionSound;
import android.media.MediaScannerConnection;

import android.os.AsyncTask;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.os.HandlerThread;
import android.util.Log;
import android.util.Range;
import android.util.Rational;
import android.util.Size;
import android.util.SparseIntArray;
import android.os.Environment;
import org.opencv.android.OpenCVLoader;
import org.opencv.android.Utils;
import org.opencv.core.Core;
import org.opencv.core.Mat;
import org.opencv.core.MatOfDouble;
import org.opencv.imgproc.Imgproc;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.ByteBuffer;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import static java.util.concurrent.TimeUnit.SECONDS;

/** ProbeintegrationPlugin */
public class ProbeintegrationPlugin implements FlutterPlugin, MethodCallHandler {
  private static final String TAG = "ProbePlugin";

  private MethodChannel channel;
  private static final String USB_EVENTS_CHANNEL = "probeintegration/usb_events";
  private EventChannel.EventSink eventSink;
  private BroadcastReceiver usbReceiver;
  private Context context;


  // Custom action for USB Permission
  private static final String ACTION_USB_PERMISSION = "com.karkinos.ACTION_USB_PERMISSION";

  String openCVStatus = "Unknown";

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "probeintegration");
    channel.setMethodCallHandler(this);
    context = flutterPluginBinding.getApplicationContext();

    // Set up EventChannel for USB attach/detach events
    EventChannel eventChannel = new EventChannel(flutterPluginBinding.getBinaryMessenger(), USB_EVENTS_CHANNEL);
    eventChannel.setStreamHandler(
        new EventChannel.StreamHandler() {
          @Override
          public void onListen(Object arguments, EventChannel.EventSink events) {
            Log.d(TAG, "onListen: called");
            eventSink = events;
            usbReceiver = createUsbReceiver();
            IntentFilter filter = new IntentFilter();
            filter.addAction(UsbManager.ACTION_USB_DEVICE_ATTACHED);
            filter.addAction(UsbManager.ACTION_USB_DEVICE_DETACHED);
            // Register our custom permission action
            filter.addAction(ACTION_USB_PERMISSION);
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
              boolean listenToBroadcastsFromOtherApps = false;

              int receiverFlags = listenToBroadcastsFromOtherApps
                      ? ContextCompat.RECEIVER_EXPORTED
                      : ContextCompat.RECEIVER_NOT_EXPORTED;
              ContextCompat.registerReceiver(context, usbReceiver, filter, receiverFlags);

            }
            else{
              context.registerReceiver(usbReceiver, filter);
            }
          }

          @Override
          public void onCancel(Object arguments) {
            Log.d("UsbReceiver", "onCancel: receiver cancelled");
            if (usbReceiver != null) {
              context.unregisterReceiver(usbReceiver);
            }
            usbReceiver = null;
          }
        });

    // Initialize OpenCV
    if (OpenCVLoader.initLocal()) {
      Log.i(TAG, "OpenCV loaded successfully");
      openCVStatus = "OpenCV Loaded";
    } else {
      Log.e(TAG, "OpenCV initialization failed!");
      openCVStatus = "OpenCV Init Failed";
      return;
    }
  }

  /**
   * Create our USB broadcast receiver that listens for:
   * - USB device attached
   * - USB device detached
   * - USB permission events
   */
  private BroadcastReceiver createUsbReceiver() {
    return new BroadcastReceiver() {
      @Override
      public void onReceive(Context context, Intent intent) {
        String action = intent.getAction();
        if (action == null)
          return;
        if (eventSink == null) {
          return;
        }
        switch (action) {
          case UsbManager.ACTION_USB_DEVICE_ATTACHED:
            Log.d(TAG, "onReceive: USB_ATTACHED ");
            eventSink.success("USB_ATTACHED");
            UsbDevice attachedDevice = intent.getParcelableExtra(UsbManager.EXTRA_DEVICE);
            if (attachedDevice != null) {
              requestUsbPermission(attachedDevice);
            }
            break;

          case UsbManager.ACTION_USB_DEVICE_DETACHED:
            Log.d(TAG, "onReceive: USB_DISCONNECTED");
            eventSink.success("USB_DISCONNECTED");
            break;

          case ACTION_USB_PERMISSION:
            Log.d(TAG, "onReceive: ACTION_USB_PERMISSION");
            synchronized (this) {
              UsbDevice device = intent.getParcelableExtra(UsbManager.EXTRA_DEVICE);
              if (device != null) {
                if (intent.getBooleanExtra(UsbManager.EXTRA_PERMISSION_GRANTED, false)) {
                  Log.d(TAG, "onReceive: USB PERMISSION GRANTED");
                  eventSink.success("USB_PERMISSION_GRANTED");
                  // TODO: If you need to do something with the device once permission is granted,
                  // do it here
                } else {
                  Log.d(TAG, "onReceive: USB PERMISSION DENIED");
                  eventSink.success("USB_PERMISSION_DENIED");
                }
              }
            }
            break;

          default:
            Log.w("UsbReceiver", "Unhandled action: " + action);
        }
      }
    };
  }

  /**
   * Helper method to request permission from the user for a given UsbDevice.
   */
  private void requestUsbPermission(UsbDevice device) {
    Log.d(TAG, "requestUsbPermission: " + device.getDeviceId());
    UsbManager usbManager = (UsbManager) context.getSystemService(Context.USB_SERVICE);
    // PendingIntent flag depends on your target SDK. For newer APIs you may need
    // FLAG_MUTABLE or FLAG_IMMUTABLE.
    PendingIntent permissionIntent = PendingIntent.getBroadcast(
        context,
        0,
        new Intent(ACTION_USB_PERMISSION),
        PendingIntent.FLAG_MUTABLE);
    usbManager.requestPermission(device, permissionIntent);
  }

  private boolean hasUsbDevicesPermission() {
    UsbManager usbManager = (UsbManager) context.getSystemService(Context.USB_SERVICE);

    if (usbManager == null) {
      // Could not get the UsbManager; return false or handle error
      return false;
    }

    // Check all currently attached USB devices
    for (UsbDevice device : usbManager.getDeviceList().values()) {
      // If there is a device for which we do NOT have permission, return false
      if (!usbManager.hasPermission(device)) {
        return false;
      }
    }

    // If we reach here, we have permission for all currently attached USB devices
    return true;
  }

  /**
   * Returns map of connected USB devices: name -> productName.
   */
  private Map<String, String> getConnectedUsbDevices() {
    UsbManager usbManager = (UsbManager) context.getSystemService(Context.USB_SERVICE);
    HashMap<String, UsbDevice> deviceList = usbManager.getDeviceList();
    Map<String, String> devices = new HashMap<>();
    for (UsbDevice device : deviceList.values()) {
      try{
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
          Log.d(TAG, "getConnectedUsbDevices: Device information device ID : "+device.getDeviceId()+" serial NUmber:"+device.getSerialNumber()+" getProductId: "+device.getProductId()+" getVendorId: "+device.getVendorId());
        }
      }
      catch (Exception ex){
        Log.d(TAG, "getConnectedUsbDevices: errror whiele ");
      }
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
        devices.put(device.getDeviceName(), device.getProductName());
        // requestUsbPermission(device);
      }
    }
    return devices;
  }

  private void requestUsbDevicesPermission() {
    UsbManager usbManager = (UsbManager) context.getSystemService(Context.USB_SERVICE);
    HashMap<String, UsbDevice> deviceList = usbManager.getDeviceList();
    Map<String, String> devices = new HashMap<>();
    for (UsbDevice device : deviceList.values()) {

      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
        devices.put(device.getDeviceName(), device.getProductName());
        requestUsbPermission(device);
      }
    }
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    switch (call.method) {
      case "getPlatformVersion":
        String platformVersion = getPlatformVersion();
        result.success(platformVersion);
        break;

      case "playShutterSound":
        playShutterSound();
        result.success("Success");
        break;

      case "processCapturedImage":
        String imageOnePath = call.argument("imageOnePath");
        String imageTwoPath = call.argument("imageTwoPath");
        String processStatus = processCapturedImage(imageOnePath, imageTwoPath);
        result.success(processStatus);
        break;
        case "processCapturedImageInBytes":
        String imageOnePathInBytes = call.argument("imageOnePath");
        String imageTwoPathInBytes = call.argument("imageTwoPath");
        Map<String,byte[]> processStatusInBytes = processCapturedImageInBytes(imageOnePathInBytes, imageTwoPathInBytes);
        result.success(processStatusInBytes);
        break;

      case "getConnectedUsbDevices":
        result.success(getConnectedUsbDevices());
        break;
      case "requestUSBPermission":
        requestUsbDevicesPermission();
        result.success("");
        break;
      case "hasUSBPermission":
        result.success(hasUsbDevicesPermission());
        break;
      default:
        result.notImplemented();
        break;
    }
  }

  public String getPlatformVersion() {
    return "Android " + android.os.Build.VERSION.RELEASE + "\t" + openCVStatus;
  }

  String IMAGE_PROCESS_STATUS_FAILED = "Failed";

  private String getImageUri() {
    String timeStamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date());
    String photoName = timeStamp;
    return photoName;
  }

  public Map<String, byte[]> processCapturedImageInBytes(String imageWLPath, String imageFLPath) {
    Map<String, byte[]> combinedResult = new HashMap<>();

    Map<String, byte[]> wlData = processImageWLInBytes(imageWLPath);
    Map<String, byte[]> flData = processImageFLInBytes(imageFLPath);

    // Combine both maps into the result
    combinedResult.putAll(wlData);
    combinedResult.putAll(flData);

    return combinedResult;
  }

  private Map<String, byte[]> processImageFLInBytes(String imagePath) {
    Map<String, byte[]> imageMap = new HashMap<>();
    File fileToMoveFL = new File(imagePath);

    byte[] imageData = null;
    try {

      byte[] originalImageData = new byte[0];

      if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
        originalImageData = Files.readAllBytes(fileToMoveFL.toPath());
      }

      Bitmap greenChannelBitmap = BitmapFactory.decodeFile(fileToMoveFL.getAbsolutePath());
//      greenChannelBitmap = Bitmap.createScaledBitmap(greenChannelBitmap, 996, 1770, false);

      int width = greenChannelBitmap.getWidth();
      int height = greenChannelBitmap.getHeight();

      pix = new int[width * height];
      g_pix = new int[width * height];
      greenChannelBitmap.getPixels(pix, 0, width, 0, 0, width, height);

      for (int i = 0; i < height; i++) {
        for (int j = 0; j < width; j++) {
          int color = pix[width * i + j];
          int alphaValue = color >> 24 & 0xff;
          int redValue = color >> 16 & 0xff;
          int greenValue = color >> 8 & 0xff;
          int blueValue = color & 0xff;

          blueValue = blueValue - (int) (blueValue * 0.7);

          redValue = Math.max(0, Math.min(255, redValue));
          greenValue = Math.max(0, Math.min(255, greenValue));
          blueValue = Math.max(0, Math.min(255, blueValue));

          g_pix[width * i + j] = alphaValue << 24 | redValue << 16 | greenValue << 8 | blueValue;
        }
      }

      Bitmap gBitmap = Bitmap.createBitmap(width, height, Bitmap.Config.RGB_565);
      gBitmap.setPixels(g_pix, 0, width, 0, 0, width, height);

      ByteArrayOutputStream stream = new ByteArrayOutputStream();
      gBitmap.compress(Bitmap.CompressFormat.JPEG, 100, stream);
      imageData = stream.toByteArray();
      stream.close();
      imageMap.put("originalFLImage", originalImageData);
      imageMap.put("processedFLImage", imageData);
    } catch (Exception e) {
      e.printStackTrace();
    }
    return imageMap;
  }

  private Map<String, byte[]> processImageWLInBytes(String imageOnePath) {
    Map<String, byte[]> imageMap = new HashMap<>();
    File fileToMoveWL = new File(imageOnePath);
    try {
      // Read the original image
      byte[] originalImageData = new byte[0];

      if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
        originalImageData = Files.readAllBytes(fileToMoveWL.toPath());
      }

      // Decode and process the image
      Bitmap colorCorrectBitmap = BitmapFactory.decodeFile(fileToMoveWL.getAbsolutePath());
//      colorCorrectBitmap = Bitmap.createScaledBitmap(colorCorrectBitmap, 996, 1770, false);

      ByteArrayOutputStream stream = new ByteArrayOutputStream();
      colorCorrectBitmap.compress(Bitmap.CompressFormat.JPEG, 100, stream);
      byte[] processedImageData = stream.toByteArray();
      stream.close();

      // Add both original and processed image data to the map
      imageMap.put("originalWLImage", originalImageData);
      imageMap.put("processedWLImage", processedImageData);
    } catch (Exception e) {
      e.printStackTrace();
    }
    return imageMap;
  }

  public String processCapturedImage(String imageWLPath, String imageFLPath) {
    String processStatus = "Failed";
    String patientid = "TestPatient";
    String location_tag = "MOUTH_LOC";
    String photoTime = getImageUri();
    String photoNameWLRaw = photoTime + "_WL_RAW_" + location_tag;
    String photoNameWL = photoTime + "_WL_" + location_tag;

    String photoNameFLRaw = photoTime + "_FL_RAW_" + location_tag;
    String photoNameFL = photoTime + "_FL_" + location_tag;

    File directoryFolder = new File(
        Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DCIM),
        "intraoral/patientPhoto/" + patientid + "/photo_WholeMouth/");
    if (!directoryFolder.exists()) {
      directoryFolder.mkdirs();
    }

    File fileWL = processImageWL(imageWLPath, photoNameWLRaw, photoNameWL, directoryFolder);
    File fileFL = processImageFL(imageFLPath, photoNameFLRaw, photoNameFL, directoryFolder);

    return fileWL.getAbsolutePath() + "~" + fileFL.getAbsolutePath();
  }

  File processImageWL(String imageOnePath, String photoNameWLRaw, String photoNameWL, File directoryFolder) {
    final File fileWLRaw = new File(directoryFolder.getAbsolutePath(), photoNameWLRaw + ".jpg");
    File fileToMoveWL = new File(imageOnePath);
    boolean isMoved = fileToMoveWL.renameTo(fileWLRaw);

    final File fileWL = new File(directoryFolder.getAbsolutePath(), photoNameWL + ".jpg");
    try {
      Bitmap colorCorrect_bitmap = BitmapFactory.decodeFile(fileWLRaw.getAbsolutePath());
      colorCorrect_bitmap = Bitmap.createScaledBitmap(colorCorrect_bitmap, 996, 1770, false);

      OutputStream fOutputStream = new FileOutputStream(fileWL);
      colorCorrect_bitmap.compress(Bitmap.CompressFormat.JPEG, 60, fOutputStream);
      fOutputStream.flush();
      fOutputStream.close();
    } catch (Exception e) {
      e.printStackTrace();
    }
    return fileWL;
  }

  private static int[] pix; // 像素点数据
  private static int[] g_pix;

  private static double[] iu_matrix;

  File processImageFL(String imagePath, String photoNameFLRaw, String photoNameFL, File directoryFolder) {
    final File fileFLRaw = new File(directoryFolder.getAbsolutePath(), photoNameFLRaw + ".jpg");
    File fileToMoveFL = new File(imagePath);
    boolean isMoved = fileToMoveFL.renameTo(fileFLRaw);

    final File fileFL = new File(directoryFolder.getAbsolutePath(), photoNameFL + ".jpg");
    try {
      Bitmap greenChannel_bitmap = BitmapFactory.decodeFile(fileFLRaw.getAbsolutePath());
      greenChannel_bitmap = Bitmap.createScaledBitmap(greenChannel_bitmap, 996, 1770, false);

      int width = greenChannel_bitmap.getWidth();
      int height = greenChannel_bitmap.getHeight();

      pix = new int[width * height];
      g_pix = new int[width * height];
      greenChannel_bitmap.getPixels(pix, 0, width, 0, 0, width, height);

      for (int i = 0; i < height; i++) {
        for (int j = 0; j < width; j++) {
          int color = pix[width * i + j];
          int alphaValue = color >> 24 & 0xff;
          int redValue = color >> 16 & 0xff;
          int greenValue = color >> 8 & 0xff;
          int blueValue = color & 0xff;

          // Example color manipulation
          blueValue = blueValue - (int) (blueValue * 0.7);

          if (redValue > 255) {
            redValue = 255;
          } else if (redValue < 0) {
            redValue = 0;
          }
          if (greenValue > 255) {
            greenValue = 255;
          } else if (greenValue < 0) {
            greenValue = 0;
          }
          if (blueValue > 255) {
            blueValue = 255;
          } else if (blueValue < 0) {
            blueValue = 0;
          }

          g_pix[width * i + j] = alphaValue << 24 | redValue << 16 | greenValue << 8 | blueValue;
        }
      }

      Bitmap g_Bitmap = Bitmap.createBitmap(width, height, Bitmap.Config.RGB_565);
      g_Bitmap.setPixels(g_pix, 0, width, 0, 0, width, height);

      OutputStream fOutputStream = new FileOutputStream(fileFL);
      g_Bitmap.compress(Bitmap.CompressFormat.JPEG, 60, fOutputStream);
      fOutputStream.flush();
      fOutputStream.close();
    } catch (Exception e) {
      e.printStackTrace();
    }
    return fileFL;
  }

  static private MediaActionSound sound = null;

  static public void playShutterSound() {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN) {
      if (sound == null) {
        sound = new MediaActionSound();
      }
      sound.play(MediaActionSound.SHUTTER_CLICK);
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
