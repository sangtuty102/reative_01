/// Chứa các hằng số chung dùng trong toàn bộ ứng dụng
class AppConstants {
  // Prevent instantiation
  AppConstants._();

  /// Tiêu đề mặc định của ứng dụng
  static const String appName = 'Reative App';

  /// Thời gian timeout mặc định cho các request mạng (tính bằng milliseconds)
  static const int connectionTimeout = 30000;

  /// Kích thước padding mặc định cho UI
  static const double defaultPadding = 16.0;
}
