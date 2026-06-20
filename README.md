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

---

## 📦 Hướng dẫn Đóng gói & Phát hành Bản cập nhật Windows (Auto-Update)

Dự án đã tích hợp sẵn tính năng tự động cập nhật và đóng gói bằng **Inno Setup 6**. Mỗi khi bạn muốn phát hành một phiên bản mới cho người dùng một cách nhanh nhất, hãy thực hiện theo quy trình 4 bước sau:

### Quy trình 4 bước phát hành nhanh nhất:

#### Bước 1: Tăng phiên bản ứng dụng
1. Mở file [pubspec.yaml](file:///E:/reative_01/pubspec.yaml).
2. Cập nhật dòng `version: 1.0.0+1` thành phiên bản mới (ví dụ: `version: 1.0.1+2` - thay đổi cả số hiệu phiên bản và số build).

#### Bước 2: Build code Windows thành phẩm
Chạy lệnh biên dịch sau trong Terminal của bạn:
```powershell
fvm flutter build windows --release -t lib/main_prod.dart
```

#### Bước 3: Đóng gói thành file cài đặt `.exe` bằng Inno Setup
Chạy lệnh đóng gói tự động dưới đây để tạo bộ cài đặt:
```powershell
& "C:\Program Files (x86)\Inno Setup 6\ISCC.exe" windows/setup.iss
```
*Lệnh này sẽ tự động lấy số phiên bản mới nhất từ file `.exe` vừa build ở Bước 2 để đóng gói thành file cài đặt hoàn chỉnh `reative_setup.exe` tại thư mục:* `build/windows/installer/reative_setup.exe`.

#### Bước 4: Đẩy lên GitHub để kích hoạt cập nhật tự động
1. Truy cập GitHub của bạn tại [github.com/sangtuty102/reative_01](https://github.com/sangtuty102/reative_01), tạo một bản **Release mới (tag v1.0.1)** và tải lên đính kèm file `reative_setup.exe` vừa tạo ở Bước 3.
2. Cập nhật tệp [version.json](file:///E:/reative_01/version.json) ở máy của bạn:
   - Điền số phiên bản mới (`version`).
   - Cập nhật nội dung mô tả bản mới (`changelog`).
   - Copy mã hash SHA256 mới của file cài đặt điền vào trường (`sha256`).
   - **Giữ nguyên** đường dẫn file cài đặt (`url`) không thay đổi.
3.1. (chính chủ) Đẩy tệp `version.json` mới lên nhánh cấu hình cập nhật (`main`) trên GitHub của bạn:
3.2. (KK). Thay đổi link `updateUrl` trong file: (E:\reative_01\lib\services\update_service.dart)
   ```powershell
   git add version.json
   git commit -m "Phát hành bản cập nhật v1.0.1"
   git push origin master
   ```

*Ngay khi hoàn tất Bước 4, toàn bộ ứng dụng của người dùng ở phiên bản cũ khi khởi động hoặc click "Kiểm tra cập nhật" sẽ tự động nhận biết có phiên bản mới, tải xuống bộ cài đặt mới và tự cài đè nâng cấp.*


