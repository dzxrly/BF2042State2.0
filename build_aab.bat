echo "Building BF2042State for Android arm64..."
flutter build appbundle --obfuscate --split-debug-info=./obfuscate  --dart-define=CHANNEL=play --build-number=%1