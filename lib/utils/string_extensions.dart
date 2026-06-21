/// Cung cấp các hàm mở rộng (extensions) cho kiểu String
extension StringExtension on String {
  /// Viết hoa chữ cái đầu tiên của chuỗi
  /// Ví dụ: "hello" -> "Hello"
  String capitalizeFirst() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Kiểm tra xem chuỗi có phải là định dạng email hợp lệ hay không
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  /// Trả về chuỗi an toàn không null. Nếu null sẽ trả về chuỗi rỗng
  String get orEmpty => this;
}

/// Cung cấp các hàm mở rộng cho String có thể null (String?)
extension NullableStringExtension on String? {
  /// Kiểm tra xem chuỗi có null hoặc rỗng hay không
  bool get isNullOrEmpty => this == null || this!.isEmpty;
}
