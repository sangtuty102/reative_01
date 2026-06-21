import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Dịch vụ quản lý phiên đăng nhập và thông tin xác thực của người dùng.
///
/// Lớp này hoạt động như một Singleton và lưu trữ trạng thái đăng nhập vào thiết bị.
class AuthService extends GetxService {
  /// Instance của SharedPreferences để đọc/ghi dữ liệu xuống ổ cứng.
  late final SharedPreferences _prefs;

  /// Trạng thái đăng nhập hiện tại của người dùng (true: đã đăng nhập, false: chưa đăng nhập).
  final RxBool isLoggedIn = false.obs;

  /// Tên tài khoản hoặc số điện thoại của người dùng đã đăng nhập thành công.
  final RxString userName = ''.obs;

  /// Khởi tạo dịch vụ và khôi phục thông tin phiên đăng nhập đã được lưu trữ trước đó.
  Future<AuthService> init() async {
    _prefs = await SharedPreferences.getInstance();
    
    // Đọc thông tin đã lưu
    isLoggedIn.value = _prefs.getBool('isLoggedIn') ?? false;
    userName.value = _prefs.getString('userName') ?? '';
    
    return this;
  }

  /// Ghi nhớ phiên đăng nhập của người dùng sau khi xác thực thành công.
  Future<void> saveLoginSession(String phone) async {
    isLoggedIn.value = true;
    userName.value = phone;

    await _prefs.setBool('isLoggedIn', true);
    await _prefs.setString('userName', phone);
  }

  /// Xóa sạch thông tin phiên đăng nhập hiện tại trên thiết bị khi người dùng đăng xuất.
  Future<void> clearSession() async {
    isLoggedIn.value = false;
    userName.value = '';

    await _prefs.remove('isLoggedIn');
    await _prefs.remove('userName');
  }
}
