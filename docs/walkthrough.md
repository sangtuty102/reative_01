# Walkthrough: Multi-Flavor Configuration & Windows Packaging with Auto-Update

We have successfully configured three environment flavors (**dev**, **uat**, and **prod**) in the `reative_01` Flutter project, and implemented Windows packaging using Inno Setup alongside an in-app auto-update capability.

---

## 🛠️ Summary of Changes Made

### 1. Multi-Flavor Configuration
- **[flavor_config.dart](file:///E:/reative_01/lib/flavor_config.dart):** Stores active flavor, API base URLs, application titles, and theme colors.
- **[main_dev.dart](file:///E:/reative_01/lib/main_dev.dart):** Entrypoint for **dev** environment.
- **[main_uat.dart](file:///E:/reative_01/lib/main_uat.dart):** Entrypoint for **uat** environment.
- **[main_prod.dart](file:///E:/reative_01/lib/main_prod.dart):** Entrypoint for **prod** environment.
- **[build.gradle](file:///E:/reative_01/android/app/build.gradle):** Defined Gradle product flavors and dynamic app names, reading passwords from `key.properties`.
- **[AndroidManifest.xml](file:///E:/reative_01/android/app/src/main/AndroidManifest.xml):** Configured dynamic app names for Android.
- **[flavorizr.yaml](file:///E:/reative_01/flavorizr.yaml):** Cross-platform flavor mapping configuration for iOS.

### 2. Packages Added
- **`package_info_plus`**: Fetch local app version information.
- **`path_provider`**: Access system temporary folders to download installers.
- **`http`**: Send API requests and stream files for the updater.

### 3. Auto-Update Service
- **[update_service.dart](file:///E:/reative_01/lib/services/update_service.dart):**
  - Fetches version metadata (`version.json`) from a server.
  - Compares the server's semantic version with the local app version.
  - Downloads the new installer executable in a stream with progress tracking.
  - Launches the installer detached and closes the Flutter app (`exit(0)`) so the installer can replace the files.

### 4. UI Update Interface
- **[main.dart](file:///E:/reative_01/lib/main.dart):**
  - Added a "Kiểm tra cập nhật" button inside the Flavor Info Card.
  - Added silent update check on startup.
  - Created a modal dialog with progress indicators showing the update progress.
  - Wrapped the main page body inside a `SingleChildScrollView` to prevent layout overflows (both vertically and horizontally).

### 5. Inno Setup Configuration
- **[setup.iss](file:///E:/reative_01/windows/setup.iss):**
  - Configures AppId, AppName, and Mutex.
  - **Tự động đồng bộ Version:** Sử dụng preprocessor `GetFileVersion` để trích xuất trực tiếp phiên bản của ứng dụng từ file biên dịch `reative_01.exe` (khiến Inno Setup luôn tự động cập nhật phiên bản tương ứng với cấu hình trong `pubspec.yaml` mà bạn không cần sửa thủ công file `.iss`).
  - Directs Inno Setup to package all binary assets inside `build\windows\x64\runner\Release\*`.
  - Sets up automated application closure during update using `CloseApplications=yes` and `AppMutex`.

---

## 🔑 Keystore Setup for Android Application Signing

To sign your production builds, you need to generate a Keystore file using the `keytool` utility.

### Step 1: Generate the Keystore (`key.jks`)
Run the following command in your terminal to generate a keystore file. 

```bash
keytool -genkey -v -keystore android/app/key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias reative_key
```

- **Keystore passwords:** Enter `reative123` (used as placeholder in `key.properties`).
- **Details:** Fill in your name, organization, city, country, etc.
- **Confirm:** Type `yes` and hit Enter.
- This will output a `key.jks` file located inside `android/app/`.

### Step 2: Verification of configurations
The `android/key.properties` file has been pre-configured as follows:
```properties
storePassword=reative123
keyPassword=reative123
keyAlias=reative_key
storeFile=key.jks
```
When running the production build (`fvm flutter build apk --flavor prod -t lib/main_prod.dart`), Gradle will automatically locate the properties and sign the APK.

---

## 🚀 How to Run and Build on Each Platform

### 💻 1. Windows Desktop
- **Dev:** `fvm flutter run -d windows -t lib/main_dev.dart`
- **UAT:** `fvm flutter run -d windows -t lib/main_uat.dart`
- **Prod:** `fvm flutter run -d windows -t lib/main_prod.dart`

To build the executable:
- **Dev:** `fvm flutter build windows -t lib/main_dev.dart`
- **UAT:** `fvm flutter build windows -t lib/main_uat.dart`
- **Prod:** `fvm flutter build windows -t lib/main_prod.dart`

### 📱 2. Android (Native Flavors)
- **Dev:** `fvm flutter run --flavor dev -t lib/main_dev.dart`
- **UAT:** `fvm flutter run --flavor uat -t lib/main_uat.dart`
- **Prod:** `fvm flutter run --flavor prod -t lib/main_prod.dart`

To build the APK:
- **Dev:** `fvm flutter build apk --flavor dev -t lib/main_dev.dart`
- **UAT:** `fvm flutter build apk --flavor uat -t lib/main_uat.dart`
- **Prod:** `fvm flutter build apk --flavor prod -t lib/main_prod.dart`

### 🍏 3. iOS (To be run on macOS Xcode environment)
1. Execute the automated Xcode scheme generation:
   ```bash
   fvm flutter pub get
   fvm flutter pub run flutter_flavorizr
   ```
2. Run the app:
   - **Dev:** `fvm flutter run --flavor dev -t lib/main_dev.dart`
   - **UAT:** `fvm flutter run --flavor uat -t lib/main_uat.dart`
   - **Prod:** `fvm flutter run --flavor prod -t lib/main_prod.dart`

---

## 📦 How to Build & Pack the Windows Application

### Step 1: Compile the Flutter App in Release Mode
Run the following build command:
```powershell
fvm flutter build windows --release -t lib/main_prod.dart
```
This output folder will be created at: `E:\reative_01\build\windows\x64\runner\Release`

### Step 2: Open Inno Setup and Compile
1. Download and install **Inno Setup** on Windows.
2. Open the file `E:\reative_01\windows\setup.iss`.
3. Press **Compile** (or `Ctrl + F9`).
4. The generated installer will be saved at: `E:\reative_01\build\windows\installer\reative_setup.exe`

---

## 🔬 How to Test Auto-Update Locally

1. **Host a local server:**
   Create a folder `server_test` on your computer. Inside, create a `version.json` file:
   ```json
   {
     "version": "1.0.1",
     "url": "http://127.0.0.1:8000/reative_setup.exe",
     "changelog": "- Sửa một số lỗi giao diện\n- Bổ sung chức năng tự động cập nhật"
   }
   ```
   Place the compiled installer `reative_setup.exe` in the same directory.
   Start a local Python server in that directory:
   ```powershell
   python -m http.server 8000
   ```

2. **Configure UpdateService URL:**
   In [update_service.dart](file:///E:/reative_01/lib/services/update_service.dart#L28-L29), change `updateUrl` to your local server (or keep your GitHub Raw link for direct live testing):
   ```dart
   // For local testing:
   static const String updateUrl = 'http://127.0.0.1:8000/version.json';

   // For live deployment:
   static const String updateUrl = 'https://raw.githubusercontent.com/sangtuty102/reative_01/main/version.json';
   ```

3. **Install Version 1.0.0:**
   - Make sure your app version in `pubspec.yaml` is `1.0.0`.
   - Compile the app and compile the installer.
   - Run the installer to install Version 1.0.0 to your system and run it.

4. **Prepare Version 1.0.1 on the Server:**
   - Change your `pubspec.yaml` version to `1.0.1`.
   - Compile the app and compile a new installer.
   - Copy this new installer `reative_setup.exe` to your `server_test` folder.

5. **Test Update:**
   - Open your installed Version 1.0.0 application.
   - Click "Kiểm tra cập nhật".
   - The app will prompt you that Version 1.0.1 is available.
   - Click "Cập nhật". The app will download the installer, start it, and automatically close.

---

## 🔒 Mobile & Windows Desktop Configurations (New Updates)

### 1. Tắt tính năng đồng bộ dữ liệu trên mobile (Android, iOS)
- **Android Auto Backup:** Đã thiết lập `android:allowBackup="false"` and `android:fullBackupContent="@null"` trong [AndroidManifest.xml](file:///E:/reative_01/android/app/src/main/AndroidManifest.xml) để chặn Google Drive tự động sao lưu dữ liệu ứng dụng lên đám mây.
- **iOS iCloud Sync:** Mặc định iOS chỉ sao lưu các tệp lưu trong thư mục `Documents`. Ứng dụng hiện tại hoàn toàn không lưu trữ bất kỳ tệp tin hay cơ sở dữ liệu nào tại đây, nên không có dữ liệu nào bị đồng bộ lên iCloud.

### 2. Giới hạn kích thước tối thiểu (Min Window Size) của ứng dụng Windows
- Đã can thiệp vào sự kiện nhận tin nhắn hệ thống `WM_GETMINMAXINFO` trong tệp native C++ của Windows [win32_window.cpp](file:///E:/reative_01/windows/runner/win32_window.cpp).
- Giới hạn kích thước cửa sổ tối thiểu là **450x600 logical pixels** (tự động nhân tỉ lệ DPI của màn hình hiện tại để hiển thị chuẩn xác trên cả màn hình High-DPI/4K).
