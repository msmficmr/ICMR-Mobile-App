import java.util.Properties
import java.io.File
import java.io.FileInputStream

import java.util.Base64
plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val envVariables: Map<String, String> = if (project.hasProperty("dart-defines")) {
    (project.property("dart-defines") as String)
        .split(",")
        .associate { entry ->
            // Decode the base64-encoded entry and split it into key and value
            val decoded = String(Base64.getDecoder().decode(entry), Charsets.UTF_8)
            val (key, value) = decoded.split("=", limit = 2)
            key to value
        }
} else {
    emptyMap()
}
//println("Loaded envVariables: $envVariables")


val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    FileInputStream(keystorePropertiesFile).use { keystoreProperties.load(it) }
}

val localProperties = Properties()
val localPropertiesFile = rootProject.file("local.properties")
if (localPropertiesFile.exists()) {
    FileInputStream(localPropertiesFile).use { localProperties.load(it) }
}
android {
    namespace = "com.example.mhealth"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.mhealth"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

flavorDimensions += "default"
    productFlavors {
        create("sit") {
            dimension = "default"
            resValue("string", "app_name", envVariables["APP_NAME"] ?: "Sit mHealth")
            applicationIdSuffix = envVariables["APP_SUFFIX"] ?: ".sit"
            flutter {
                target = "lib/main_sit.dart"
            }
        }
        create("qa") {
            dimension = "default"
            resValue("string", "app_name", envVariables["APP_NAME"] ?: "QA mHealth")
            applicationIdSuffix = envVariables["APP_SUFFIX"] ?: ".qa"
            flutter {
                target = "lib/main_qa.dart"
            }
        }
        create("prod") {
            dimension = "default"
            resValue("string", "app_name", envVariables["APP_NAME"] ?: "mHealth")
            applicationIdSuffix = envVariables["APP_SUFFIX"] ?: ""
            flutter {
                target = "lib/main_prod.dart"
            }
        }
    }
    signingConfigs {
        create("release") {
            storeFile = keystoreProperties["storeFile"]?.let { rootProject.file(it) }
            storePassword = keystoreProperties["storePassword"] as String?
            keyAlias = keystoreProperties["keyAlias"] as String?
            keyPassword = keystoreProperties["keyPassword"] as String?
        }
    }
    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }

    packagingOptions {
        pickFirsts.add("lib/arm64-v8a/libc++_shared.so")
        pickFirsts.add("lib/x86_64/libc++_shared.so")
        pickFirsts.add("lib/x86/libc++_shared.so")
        pickFirsts.add("lib/armeabi-v7a/libc++_shared.so")
    }
}

flutter {
    source = "../.."
}
