/// Cung cấp các hàm mở rộng (extensions) cho kiểu num (int, double)
extension NumExtension on num {
  /// Format số thành tiền tệ Việt Nam Đồng (VND)
  /// Ví dụ: 1000000 -> "1.000.000 đ"
  String toVND() {
    return '${toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')} đ';
  }

  /// Delay một khoảng thời gian sử dụng số hiện tại làm milliseconds
  /// Ví dụ: 1000.millisecondsDelay() sẽ delay 1 giây (trả về Future)
  Future<void> millisecondsDelay() {
    return Future.delayed(Duration(milliseconds: toInt()));
  }
}
