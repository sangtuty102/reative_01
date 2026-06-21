/// Cung cấp các hàm tiện ích (utilities) phổ biến dùng trong app
class FormatUtils {
  // Prevent instantiation
  FormatUtils._();

  /// Định dạng số điện thoại (ví dụ: 0987654321 -> 0987 654 321)
  static String formatPhoneNumber(String phone) {
    if (phone.length == 10) {
      return '${phone.substring(0, 4)} ${phone.substring(4, 7)} ${phone.substring(7)}';
    }
    return phone;
  }

  /// Rút gọn tên nếu quá dài
  static String shortenName(String name, {int maxLength = 20}) {
    if (name.length <= maxLength) return name;
    return '${name.substring(0, maxLength)}...';
  }
}
