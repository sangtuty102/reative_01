# Hướng dẫn Quản lý Đa Ngôn Ngữ (i18n)

Dự án sử dụng cơ chế đa ngôn ngữ kết hợp giữa JSON phân cấp (Nested JSON) để quản lý text dễ dàng cho team dịch thuật, và `GetX` để tăng tốc độ truy xuất trên View/Controller bằng các biến hằng số.

> [!TIP]
> **🚀 Tóm tắt nhanh (Cheat Sheet) cho Dev:**
> 1. Mở file `.json` trong `assets/lang/en` và `vi` ra cập nhật.
> 2. Gõ lệnh `dart run scripts/gen_lang.dart` để tự đẻ ra biến hằng số `LocaleKeys`.
> 3. Thay vì gõ text vào code, gọi `LocaleKeys.[tên_biến].tr` là xong.
## 📂 Cấu trúc thư mục

```text
assets/lang/
├── en/                 # Nhánh tiếng Anh
│   ├── common.json     # Chứa text dùng chung (Lỗi, Thành công, Hủy, Tiếp tục...)
│   ├── home.json       # Chứa text của màn hình Home
│   └── login.json      # Chứa text của luồng Login
└── vi/                 # Nhánh tiếng Việt
    ├── common.json
    ├── home.json
    └── login.json
```

## 📝 Quy trình thêm/sửa chữ trên ứng dụng

Khi bạn cần thêm một đoạn text mới vào ứng dụng, tuyệt đối **KHÔNG** gõ trực tiếp (hard-code) text cứng vào trong file `.dart`. Hãy làm theo 3 bước sau:

### Bước 1: Khai báo vào file JSON
Truy cập thư mục `assets/lang/en/` và `assets/lang/vi/`. Mở file `.json` tương ứng với tính năng bạn đang làm. 
*Lưu ý: Luôn nhóm các key vào trong object root mang tên file để tránh conflict với file khác.*

Ví dụ trong `assets/lang/vi/home.json`:
```json
{
  "home": {
    "welcome_message": "Chào mừng bạn trở lại!"
  }
}
```

### Bước 2: Sinh code tự động (Generate Code)
Sau khi chỉnh sửa xong JSON, mở Terminal và chạy lệnh sau để tự động tổng hợp JSON và sinh code Dart:
```bash
dart run scripts/gen_lang.dart
```

Lệnh này sẽ tự động:
1. Gộp tất cả các file JSON con thành 2 file tổng `en.json` và `vi.json`.
2. Ép phẳng (flatten) các key và sinh ra DUY NHẤT một file `lib/generated/locales.g.dart`. File này chứa toàn bộ `AppTranslations`, `Locales` (dữ liệu dịch) và `LocaleKeys` (các hằng số đại diện cho key).

### Bước 3: Sử dụng trên giao diện
Vào file View hoặc Controller của bạn, import file `locales.g.dart` và gọi text thông qua cấu trúc `LocaleKeys.[tên_key].tr`. Text sẽ được tự động đổi sang dạng `camelCase`.

Ví dụ:
```dart
import 'package:reative_01/generated/locales.g.dart';

// Key "welcome_message" trong JSON sẽ tự động trở thành biến "welcomeMessage"
Text(LocaleKeys.homeWelcomeMessage.tr); 
```

## 🛠 Lợi ích của kiến trúc này
1. **An toàn (Type-safe):** Code thông qua `LocaleKeys` giúp IDE gợi ý tự động, không bao giờ lo gõ sai chính tả chuỗi String.
2. **Tránh Conflict (Làm việc nhóm):** Mỗi người làm một chức năng sẽ chỉ sửa file JSON của chức năng đó, khi merge code Git sẽ không dẫm chân lên nhau.
3. **Thân thiện với team biên dịch:** Bạn có thể gửi thẳng các file `en.json` cho team dịch thuật bên ngoài mà không cần bắt họ phải biết code Dart.
