#!/usr/bin/env bash
set -e
flutter create .
flutter pub get
cp android_overlay/app/src/main/AndroidManifest.xml android/app/src/main/AndroidManifest.xml
echo "WoodID Android preparado."
echo "Arranca backend y luego ejecuta:"
echo "flutter run --dart-define=WOODID_API_URL=http://10.0.2.2:8000"
