/// Chứa các đường dẫn (paths) của assets như hình ảnh, icons, animations,...
class AppPaths {
  // Prevent instantiation
  AppPaths._();

  /// Đường dẫn thư mục chứa hình ảnh
  static const String imagePath = 'assets/images/';

  /// Đường dẫn thư mục chứa icons
  static const String iconPath = 'assets/icons/';

  /// Hình ảnh placeholder khi bị lỗi tải
  static const String placeholderImage = '${imagePath}placeholder.png';
}
