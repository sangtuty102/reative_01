import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

/// Lớp đại diện cho thông tin bản cập nhật mới nhận từ máy chủ.
class UpdateInfo {
  /// Phiên bản trên máy chủ (ví dụ: "1.0.1+2").
  final String serverVersion;

  /// Đường dẫn liên kết trực tiếp để tải về bộ cài đặt installer.
  final String downloadUrl;

  /// Nhật ký các thay đổi hoặc tính năng mới của phiên bản này.
  final String changelog;

  UpdateInfo({
    required this.serverVersion,
    required this.downloadUrl,
    required this.changelog,
  });

  /// Hàm dựng Factory để phân tích dữ liệu JSON nhận được từ máy chủ.
  factory UpdateInfo.fromJson(Map<String, dynamic> json) {
    return UpdateInfo(
      serverVersion: json['version'] ?? '',
      downloadUrl: json['url'] ?? '',
      changelog: json['changelog'] ?? '',
    );
  }
}

/// Dịch vụ quản lý kiểm tra cập nhật và thực hiện tải, cài đặt tự động trên Windows.
class UpdateService {
  /// Đường dẫn tĩnh của file metadata version.json lưu trữ trên Github.
  static const String updateUrl = 'https://raw.githubusercontent.com/sangtuty102/reative_01/main/version.json';

  /// Kiểm tra xem có phiên bản cập nhật mới hơn trên máy chủ hay không.
  ///
  /// Trả về [UpdateInfo] nếu có phiên bản mới, ngược lại trả về `null`.
  static Future<UpdateInfo?> checkForUpdate() async {
    // Chỉ kiểm tra cập nhật khi chạy trên Windows và không phải Web
    if (!kIsWeb && Platform.isWindows) {
      try {
        final response = await http.get(Uri.parse(updateUrl)).timeout(const Duration(seconds: 10));
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final updateInfo = UpdateInfo.fromJson(data);
          
          final packageInfo = await PackageInfo.fromPlatform();
          final currentVersion = packageInfo.version;

          if (_hasNewVersion(currentVersion, updateInfo.serverVersion)) {
            return updateInfo;
          }
        }
      } catch (e) {
        debugPrint('Error checking for updates: $e');
      }
    }
    return null;
  }

  /// So sánh hai chuỗi phiên bản semantic version.
  ///
  /// Trả về `true` nếu phiên bản server lớn hơn phiên bản hiện tại của ứng dụng.
  static bool _hasNewVersion(String currentVersion, String serverVersion) {
    try {
      final currentSplit = currentVersion.split('+');
      final serverSplit = serverVersion.split('+');

      final currentParts = currentSplit[0].split('.').map(int.parse).toList();
      final serverParts = serverSplit[0].split('.').map(int.parse).toList();

      // 1. So sánh major.minor.patch
      for (var i = 0; i < 3; i++) {
        final cur = (i < currentParts.length) ? currentParts[i] : 0;
        final sev = (i < serverParts.length) ? serverParts[i] : 0;
        if (sev > cur) return true;
        if (cur > sev) return false;
      }

      // 2. So sánh build number sau dấu "+" nếu phiên bản chính bằng nhau
      final curBuild = (currentSplit.length > 1) ? int.tryParse(currentSplit[1]) ?? 0 : 0;
      final sevBuild = (serverSplit.length > 1) ? int.tryParse(serverSplit[1]) ?? 0 : 0;
      return sevBuild > curBuild;
    } catch (e) {
      debugPrint('Error parsing version strings: $e');
    }
    return false;
  }

  /// Tải file cài đặt `.exe` mới và khởi chạy tiến trình cài đặt độc lập.
  ///
  /// Sau khi tải hoàn tất, ứng dụng sẽ tắt (`exit(0)`) để tiến trình cài đặt có thể ghi đè file.
  static Future<void> downloadAndInstall({
    required String url,
    required Function(double progress) onProgress,
    required Function(String error) onError,
  }) async {
    try {
      final client = http.Client();
      final request = http.Request('GET', Uri.parse(url));
      final response = await client.send(request).timeout(const Duration(seconds: 15));

      if (response.statusCode != 200) {
        onError('Server error: ${response.statusCode}');
        client.close();
        return;
      }

      final contentLength = response.contentLength ?? 0;
      final tempDir = await getTemporaryDirectory();
      final installerFile = File('${tempDir.path}\\reative_setup_update.exe');
      
      if (await installerFile.exists()) {
        await installerFile.delete();
      }

      final sink = installerFile.openWrite();
      int downloadedBytes = 0;

      try {
        await for (final chunk in response.stream) {
          sink.add(chunk);
          downloadedBytes += chunk.length;
          if (contentLength > 0) {
            onProgress(downloadedBytes / contentLength);
          }
        }
      } catch (e) {
        await sink.close();
        client.close();
        onError('Download failed: $e');
        return;
      }

      await sink.close();
      client.close();

      // Khởi chạy file cài đặt độc lập (detached process)
      await Process.start(
        installerFile.path,
        [],
        mode: ProcessStartMode.detached,
      );
      
      // Tắt ứng dụng Flutter lập tức để bộ cài đặt ghi đè tệp tin thực thi
      exit(0);
    } catch (e) {
      onError('Update failed: $e');
    }
  }
}
