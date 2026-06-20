# reative_01 (Flavored Flutter App)

Dự án Flutter đã cấu hình sẵn 3 môi trường: **Dev**, **UAT**, và **Prod**.

---

## 🚀 Hướng dẫn Build môi trường Production (PROD)

Để build ứng dụng thành phẩm cho môi trường production, bạn mở Terminal/CMD tại thư mục dự án và chạy các lệnh tương ứng dưới đây:

### 1. Build cho Android
*   **Build file APK (Để cài đặt trực tiếp):**
    ```bash
    fvm flutter build apk --flavor prod -t lib/main_prod.dart
    ```
    *File APK sau khi build xong sẽ nằm ở thư mục:* `build/app/outputs/flutter-apk/app-prod-release.apk`

*   **Build file App Bundle (AAB - Để upload lên Google Play Store):**
    ```bash
    fvm flutter build appbundle --flavor prod -t lib/main_prod.dart
    ```
    *File AAB sau khi build xong sẽ nằm ở thư mục:* `build/app/outputs/bundle/prodRelease/app-prod-release.aab`

### 2. Build cho Windows (Desktop)
*   **Build file executable (.exe) cho Windows:**
    ```bash
    fvm flutter build windows -t lib/main_prod.dart
    ```
    *Thư mục chứa ứng dụng Windows sau khi build:* `build/windows/x64/runner/Release/`

### 3. Build cho iOS (Yêu cầu chạy trên hệ điều hành macOS)
*   **Bước chuẩn bị:** (Chỉ chạy 1 lần đầu tiên trên macOS để sinh các Xcode Scheme):
    ```bash
    fvm flutter pub get
    fvm flutter pub run flutter_flavorizr
    ```
*   **Build gói IPA (Để upload lên App Store / TestFlight):**
    ```bash
    fvm flutter build ipa --flavor prod -t lib/main_prod.dart
    ```

---

## 🛠️ Hướng dẫn Chạy & Debug trong quá trình phát triển

Để thuận tiện nhất, bạn nên mở thư mục dự án này bằng **VS Code** hoặc **Antigravity IDE**:
1. Nhấn `Ctrl + Shift + D` (hoặc click vào tab **Run & Debug** ở thanh bên trái).
2. Nhấp vào danh sách cấu hình trên cùng và chọn một trong các cấu hình mong muốn (ví dụ: `Debug DEV (Windows Desktop)` hoặc `Debug PROD (Android/iOS)`).
3. Nhấn **F5** để bắt đầu chạy Debug kèm tính năng Hot Reload.

