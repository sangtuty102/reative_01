# Tài Liệu Cấu Trúc Mã Nguồn (App Architecture)

Dự án `reative_01` được xây dựng theo mô hình **Clean Architecture** kết hợp với thư viện quản lý trạng thái **GetX**. Kiến trúc này phân chia rõ ràng giữa tầng hiển thị (Presentation), tầng nghiệp vụ (Business Logic), và tầng cấu hình hệ thống (Core/Config).

---

## 📁 Sơ đồ cấu trúc thư mục (`lib/`)

```text
lib/
├── core/
│   ├── base/
│   │   ├── base_controller.dart     # Base class cho toàn bộ Controller (quản lý ViewState)
│   │   └── base_view.dart           # Base class cho toàn bộ UI (tự động hóa Loading/Error)
│   ├── localization/                # Cấu hình đa ngôn ngữ (i18n) và từ điển dịch
│   │   ├── app_translations.dart
│   │   └── localization_service.dart
│   ├── services/
│   │   ├── auth_service.dart        # Dịch vụ quản lý đăng nhập và phiên làm việc
│   │   └── update_service.dart      # Dịch vụ kiểm tra và tải/cài đặt tự động cập nhật
│   ├── theme/                       # Cấu hình giao diện Sáng/Tối và màu sắc
│   │   ├── app_colors.dart
│   │   ├── app_theme.dart
│   │   └── theme_service.dart
│   └── widgets/
│       ├── custom_button.dart       # Nút bấm tích hợp loading xoay và trạng thái reactive
│       ├── custom_text_field.dart   # Ô nhập dữ liệu tích hợp hiển thị mật khẩu và định dạng
│       └── custom_ui_utils.dart     # Tiện ích hiển thị nhanh Dialog xác nhận và Snackbar
├── data/                            # Chứa các hằng số, đường dẫn dùng chung toàn app
│   ├── app_paths.dart
│   └── constants.dart
├── features/
│   ├── splash/                      # Tính năng Splash Screen
│   │   ├── bindings/
│   │   ├── controllers/
│   │   └── views/
│   ├── login/                       # Tính năng Đăng nhập (Phone, Password, Version)
│   │   ├── bindings/
│   │   ├── controllers/
│   │   └── views/
│   └── home/                        # Tính năng Home (Chứa Tab PageView)
│       ├── bindings/
│       ├── controllers/
│       └── views/
├── routes/
│   ├── app_pages.dart               # Khai báo liên kết Route, View và Binding
│   └── app_routes.dart              # Khai báo hằng số tên Route (/splash, /login, /home)
├── utils/                           # Chứa các hàm tiện ích, extensions mở rộng (String, num)
│   ├── format_utils.dart
│   ├── num_extensions.dart
│   └── string_extensions.dart
├── flavor_config.dart               # Cấu hình đa môi trường (dev, uat, prod)
├── main.dart                        # File khởi chạy chung (chứa MyApp)
├── main_dev.dart                    # Điểm khởi chạy môi trường Development
├── main_uat.dart                    # Điểm khởi chạy môi trường UAT
└── main_prod.dart                   # Điểm khởi chạy môi trường Production
```

---

## 🛠️ Các Thành Phần Cốt Lõi (Core Architecture)

### 1. Base Controller (`BaseController`)
Tất cả các Controller trong dự án nên kế thừa `BaseController` để sở hữu vòng đời quản lý trạng thái giao diện (`ViewState`):
- `ViewState.idle`: Trạng thái rảnh rỗi / bình thường.
- `ViewState.loading`: Trạng thái đang tải dữ liệu (sẽ tự hiển thị Loading Spinner trên View).
- `ViewState.error`: Trạng thái gặp lỗi (sẽ tự hiển thị màn hình báo lỗi).
- `ViewState.success`: Trạng thái xử lý thành công.

**Ví dụ sử dụng:**
```dart
class MyController extends BaseController {
  Future<void> fetchData() async {
    setViewState(ViewState.loading);
    try {
      // Thực hiện gọi API hoặc tác vụ nặng...
      setViewState(ViewState.success);
    } catch (e) {
      setViewState(ViewState.error);
    }
  }
}
```

### 2. Base View (`BaseView`)
Tất cả các View màn hình lớn nên kế thừa `BaseView<T extends BaseController>` thay vì `Stateless/StatefulWidget` hay `GetView`:
- Tự động lắng nghe trạng thái từ Controller để hiển thị Loading hoặc Error UI mà không cần viết lại code logic rườm rà.
- Cung cấp các hàm override thuận tiện: `buildAppBar`, `buildBody`, `buildFloatingActionButton`.

**Ví dụ sử dụng:**
```dart
class MyView extends BaseView<MyController> {
  const MyView({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(title: const Text('My Page'));
  }

  @override
  Widget buildBody(BuildContext context) {
    // Chỉ cần tập trung viết giao diện thành công tại đây,
    // Trạng thái Loading và Error đã được BaseView tự động xử lý.
    return Center(child: Text('Dữ liệu đã tải xong!'));
  }
}
```

### 3. Thành phần dùng chung (`widgets/`)
Các Widget cơ bản được đóng gói lại tại `core/widgets/` giúp tái sử dụng nhanh chóng và đồng bộ giao diện:
- **`CustomTextField`**: Đóng gói TextFormField của Flutter, tự động xử lý nút ẩn/hiển thị mật khẩu bằng Rx nội bộ, bo góc và đường viền màu chủ đạo.
- **`CustomButton`**: Tích hợp hiển thị vòng xoay Loading thay cho Text khi bấm gửi dữ liệu bất đồng bộ.
- **`CustomUiUtils`**: Cung cấp hàm hiển thị nhanh các Popup/Dialog và Snackbar mà không cần build giao diện từ đầu.

---

## 🚦 Luồng Điều Hướng & Dependency Injection (Routing & Bindings)

Dự án sử dụng Named Routing của GetX phối hợp cùng Bindings:

1. **Named Routing (`lib/routes/`)**: Định nghĩa các đường dẫn tĩnh để chuyển màn hình mà không cần truyền `BuildContext`.
   - Chuyển trang: `Get.toNamed(Routes.LOGIN);`
   - Chuyển trang và xóa lịch sử (thích hợp sau Login): `Get.offAllNamed(Routes.HOME);`
2. **Bindings**: Đảm nhận việc khởi tạo các Controller tương ứng khi chuyển vào một Route, và tự động giải phóng (dispose) Controller ra khỏi bộ nhớ khi người dùng thoát trang. giúp tối ưu RAM tối đa.

---

## 🔄 Cấu Hình Đa Môi Trường (Flavors)

Ứng dụng được thiết kế chạy trên 3 môi trường khác biệt qua cơ chế Flavor:
- **Dev**: Dùng để kiểm thử nội bộ và phát triển tính năng mới.
- **UAT**: Môi trường Staging để kiểm thử tích hợp.
- **Prod**: Môi trường chạy thực tế dành cho người dùng cuối.

Hệ thống cấu hình qua lớp `FlavorConfig` kế thừa mẫu thiết kế Singleton để dễ dàng truy xuất thông tin cấu hình (`FlavorConfig.instance.apiBaseUrl`) ở bất cứ nơi nào trong app.

---

## 📝 Quy chuẩn viết Code (Coding Conventions)

Để tối ưu hóa trải nghiệm lập trình và giúp IDE hiển thị thông tin chi tiết khi rê chuột (hover) vào các thành phần trong mã nguồn:
- **Khai báo tài liệu (`///`):** Tất cả các Class, Function, và Biến mới được tạo ra bắt buộc phải có mô tả ngắn gọn từ 1-2 dòng bằng cú pháp Dart Doc Comments (`///`).
- **Nội dung mô tả:** Cần giải thích súc tích nhiệm vụ của class, tác vụ của hàm (input/output nếu cần) và mục đích của biến.

