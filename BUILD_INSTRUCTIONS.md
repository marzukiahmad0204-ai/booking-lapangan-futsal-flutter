# Futsal Booking App - Build Instructions

## Prerequisites

Sebelum memulai build APK, pastikan Anda sudah install:

1. **Flutter SDK** (versi 3.0+)
   - Download: https://flutter.dev/docs/get-started/install
   - Set PATH: `export PATH="$PATH:[path-to-flutter]/bin"`

2. **Android SDK** & **NDK**
   - Via Android Studio > SDK Manager
   - API Level: 21 (Min SDK)
   - Target SDK: 34
   - NDK Version: 27.0.12077973

3. **Java Development Kit (JDK)** 11+
   - Download: https://www.oracle.com/java/technologies/downloads/

4. **Git** (untuk clone repository)

## Setup Project

### 1. Clone Repository
```bash
git clone https://github.com/marzukiahmad0204-ai/booking-lapangan-futsal-flutter.git
cd booking-lapangan-futsal-flutter
```

### 2. Install Flutter Dependencies
```bash
flutter pub get
```

### 3. Verify Setup
```bash
flutter doctor
```

Pastikan semua check list hijau ✓

## Build APK

### Option 1: Build Debug APK
```bash
flutter build apk --debug
```

**Output:** `build/app/outputs/flutter-apk/app-debug.apk`

### Option 2: Build Release APK (Recommended)
```bash
flutter build apk --release
```

**Output:** `build/app/outputs/flutter-apk/app-release.apk`

### Option 3: Build APK dengan Split Per ABI (Lebih Kecil)
```bash
flutter build apk --split-per-abi --release
```

**Output:**
- `build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk` (untuk ARM 32-bit)
- `build/app/outputs/flutter-apk/app-arm64-v8a-release.apk` (untuk ARM 64-bit)
- `build/app/outputs/flutter-apk/app-x86-release.apk` (untuk Intel x86)
- `build/app/outputs/flutter-apk/app-x86-64-release.apk` (untuk Intel x86_64)

### Option 4: Build Bundle (untuk Google Play Store)
```bash
flutter build appbundle --release
```

**Output:** `build/app/outputs/bundle/release/app-release.aab`

## Install APK di Device

### Via USB Device (Connected)
```bash
flutter install
```

### Via adb (Direct)
```bash
adb install build/app/outputs/flutter-apk/app-release.apk
```

### Via Android Emulator
```bash
flutter emulators --launch <emulator-id>
flutter run --release
```

## Troubleshooting

### 1. Flutter tidak ditemukan
```bash
# Pastikan Flutter sudah di PATH
export PATH="$PATH:[path-to-flutter]/bin"
```

### 2. Android SDK tidak ditemukan
```bash
# Set ANDROID_SDK_ROOT
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk  # macOS/Linux
set ANDROID_SDK_ROOT=%USERPROFILE%\AppData\Local\Android\sdk  # Windows
```

### 3. Gradle build error
```bash
# Clean build
flutter clean
flutter pub get
flutter build apk --release
```

### 4. Out of memory
```bash
# Edit android/app/build.gradle
# Tambahkan di dalam android block:
android {
    ...
    dexOptions {
        javaMaxHeapSize "4g"
    }
}
```

## Build Output Size

- **Debug APK**: ~150MB
- **Release APK**: ~50-60MB
- **Split APK**: ~20-30MB per ABI

## Optimization Tips

1. **Gunakan ProGuard untuk obfuscation**
   ```bash
   flutter build apk --release --enable-proguard
   ```

2. **Generate APK Split per ABI** untuk mengurangi ukuran

3. **Test di berbagai device** sebelum release

## Publishing ke Google Play Store

1. **Generate Signing Key**
   ```bash
   keytool -genkey -v -keystore ~/key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias futsal_booking
   ```

2. **Create keystore properties file** (`android/key.properties`)
   ```
   storePassword=<password>
   keyPassword=<password>
   keyAlias=futsal_booking
   storeFile=<path-to-key.jks>
   ```

3. **Update build.gradle** (`android/app/build.gradle`)
   ```gradle
   signingConfigs {
       release {
           keyAlias keystoreProperties['keyAlias']
           keyPassword keystoreProperties['keyPassword']
           storeFile file(keystoreProperties['storeFile'])
           storePassword keystoreProperties['storePassword']
       }
   }
   ```

4. **Build signed APK/Bundle**
   ```bash
   flutter build appbundle --release
   ```

## Useful Commands

```bash
# Run app in development
flutter run

# Run with verbose output
flutter run -v

# Run specific device
flutter devices  # List devices
flutter run -d <device-id>

# Build AAB for Play Store
flutter build appbundle --release

# Check app size
flutter build apk --analyze-size --release

# Enable ProGuard obfuscation
flutter build apk --enable-proguard --release
```

## Contacts & Support

- **Author**: Marzuki Ahmad
- **GitHub**: https://github.com/marzukiahmad0204-ai
- **Repository**: https://github.com/marzukiahmad0204-ai/booking-lapangan-futsal-flutter

---

**Happy Building! 🚀**
