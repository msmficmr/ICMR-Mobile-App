#Flutter Wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }
-keep class com.google.android.gms.ads.identifier.** { *; }
-assumenosideeffects class android.util.Log { *; }
-assumenosideeffects class 	java.util.logging.Logger { *; }
-assumenosideeffects class 	android.util.Log.println { *; }
-assumenosideeffects class android.util.Log {
    public static *** d(...);
    public static *** v(...);
    public static *** i(...);
    public static *** w(...);
    public static *** e(...);
    public static *** wtf(...);
}
# Please add these rules to your existing keep rules in order to suppress warnings.
# This is generated automatically by the Android Gradle plugin.
-dontwarn com.google.android.play.core.splitcompat.SplitCompatApplication
-dontwarn com.google.android.play.core.splitinstall.SplitInstallException
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManager
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManagerFactory
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest$Builder
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest
-dontwarn com.google.android.play.core.splitinstall.SplitInstallSessionState
-dontwarn com.google.android.play.core.splitinstall.SplitInstallStateUpdatedListener
-dontwarn com.google.android.play.core.tasks.OnFailureListener
-dontwarn com.google.android.play.core.tasks.OnSuccessListener
-dontwarn com.google.android.play.core.tasks.Task

-keep class com.jiangdg.uvc.UVCCamera {
        native <methods>;
  long mNativePtr;
  }
  -keep class com.jiangdg.uvc.IStatusCallback {
  *;
  }

# media_store_plus — plugin uses Gson to serialize SaveInfo/SaveStatus across the
# method channel. R8 was renaming the data-class fields and enum constants, so the
# JSON returned to Dart no longer contained "uri"/"name"/"save_status" and saveFile()
# silently failed in release builds.
-keep class com.snnafi.media_store_plus.** { *; }
-keepclassmembers class com.snnafi.media_store_plus.** { *; }

# Gson — keep annotations and the members it reflects on.
-keepattributes Signature, *Annotation*, EnclosingMethod, InnerClasses
-keep class com.google.gson.** { *; }
-keep class com.google.gson.reflect.TypeToken { *; }
-keep class * extends com.google.gson.reflect.TypeToken
-keepclassmembers class * {
    @com.google.gson.annotations.SerializedName <fields>;
}
-keepclassmembers,allowobfuscation,allowshrinking enum * {
    @com.google.gson.annotations.SerializedName *;
}