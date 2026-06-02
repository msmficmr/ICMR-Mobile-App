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
    compileSdk = 36
    ndkVersion = "28.2.13676358"

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
        targetSdk = 36
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }
    flavorDimensions += "default"
            productFlavors {
                create("dev") {
                    dimension = "default"
                    resValue("string", "app_name", envVariables["APP_NAME"] ?: "Dev Mhealth")
                    applicationIdSuffix = envVariables["APP_SUFFIX"] ?: ".dev"
                    
                }
                create("qa") {
                    dimension = "default"
                    resValue("string", "app_name", envVariables["APP_NAME"] ?: "QA Mhealth")
                    applicationIdSuffix = envVariables["APP_SUFFIX"] ?: ".qa"
                    
                }
                create("prod") {
                    dimension = "default"
                    resValue("string", "app_name", envVariables["APP_NAME"] ?: "Mhealth")
                    applicationIdSuffix = envVariables["APP_SUFFIX"] ?: ""
                    
                }
            }
    /*signingConfigs {
        create("release") {
            storeFile = keystoreProperties["storeFile"]?.let { rootProject.file(it) }
            storePassword = keystoreProperties["storePassword"] as String?
            keyAlias = keystoreProperties["keyAlias"] as String?
            keyPassword = keystoreProperties["keyPassword"] as String?
        }
    }*/

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
            isMinifyEnabled = true
                    proguardFiles(
                        getDefaultProguardFile("proguard-android-optimize.txt"),
                        "proguard-rules.pro"
                    )
        }
    }
     packagingOptions {
        pickFirsts.add("lib/arm64-v8a/libc++_shared.so")
        pickFirsts.add("lib/x86_64/libc++_shared.so")
        pickFirsts.add("lib/x86/libc++_shared.so")
        pickFirsts.add("lib/armeabi-v7a/libc++_shared.so")
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
