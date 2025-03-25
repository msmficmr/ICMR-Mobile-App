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

android {
    namespace = "com.mhealth.mhealth"
    compileSdk = 35
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_1_8.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.mhealth.mhealth"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }
    flavorDimensions += "default"
            productFlavors {
                create("dev") {
                    dimension = "default"
                    resValue("string", "app_name", envVariables["APP_NAME"] ?: "Dev Mhealth")
                    applicationIdSuffix = envVariables["APP_SUFFIX"] ?: ".dev"
                    project.extensions.findByType(FlutterExtension::class.java)?.let {
                        it.setTarget("lib/main_dev.dart")
                    }
                }
                create("qa") {
                    dimension = "default"
                    resValue("string", "app_name", envVariables["APP_NAME"] ?: "QA Mhealth")
                    applicationIdSuffix = envVariables["APP_SUFFIX"] ?: ".qa"
                    project.extensions.findByType(FlutterExtension::class.java)?.let {
                        it.setTarget("lib/main_qa.dart")
                    }
                }
                create("prod") {
                    dimension = "default"
                    resValue("string", "app_name", envVariables["APP_NAME"] ?: "Mhealth")
                    applicationIdSuffix = envVariables["APP_SUFFIX"] ?: ""
                    project.extensions.findByType(FlutterExtension::class.java)?.let {
                        it.setTarget("lib/main_qa.dart")
                    }
                }
            }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}
dependencies {
    implementation("androidx.localbroadcastmanager:localbroadcastmanager:1.1.0")
    // required for all Android apps
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}

flutter {
    source = "../.."
}
