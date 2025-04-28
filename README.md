# MHealth



## Release
## Android
### QA
flutter build apk --split-per-abi -t lib/main_qa.dart --flavor qa --dart-define-from-file=qa_config.json

### PROD
# steps
Check `android\app\build.gradle` buildTypes-> signingConfig->  it should in release mode
```
buildTypes {
    release {
        signingConfig signingConfigs.release
    }
}
```

flutter build appbundle  -t lib/main_prod.dart --flavor prod --dart-define-from-file=prod_config.json


### IOS
## PROD

flutter build ios -t lib/main_prod.dart --dart-define-from-file=prod_config.json
