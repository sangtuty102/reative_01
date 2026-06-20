import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

class UpdateInfo {
  final String serverVersion;
  final String downloadUrl;
  final String changelog;

  UpdateInfo({
    required this.serverVersion,
    required this.downloadUrl,
    required this.changelog,
  });

  factory UpdateInfo.fromJson(Map<String, dynamic> json) {
    return UpdateInfo(
      serverVersion: json['version'] ?? '',
      downloadUrl: json['url'] ?? '',
      changelog: json['changelog'] ?? '',
    );
  }
}

class UpdateService {
  // Public raw URL for version.json on your GitHub repository
  static const String updateUrl = 'https://raw.githubusercontent.com/sangtuty102/reative_01/main/version.json';

  /// Checks if a new version is available on the server.
  /// Returns [UpdateInfo] if a new version is available, otherwise null.
  static Future<UpdateInfo?> checkForUpdate() async {
    // Only check for updates on Windows in release or profile mode (for testing)
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

  /// Helper to compare two semantic versions.
  /// Returns true if [serverVersion] is greater than [currentVersion].
  static bool _hasNewVersion(String currentVersion, String serverVersion) {
    try {
      final currentSplit = currentVersion.split('+');
      final serverSplit = serverVersion.split('+');

      final currentParts = currentSplit[0].split('.').map(int.parse).toList();
      final serverParts = serverSplit[0].split('.').map(int.parse).toList();

      // 1. Compare major.minor.patch
      for (var i = 0; i < 3; i++) {
        final cur = (i < currentParts.length) ? currentParts[i] : 0;
        final sev = (i < serverParts.length) ? serverParts[i] : 0;
        if (sev > cur) return true;
        if (cur > sev) return false;
      }

      // 2. If version is equal, compare build number (after "+")
      final curBuild = (currentSplit.length > 1) ? int.tryParse(currentSplit[1]) ?? 0 : 0;
      final sevBuild = (serverSplit.length > 1) ? int.tryParse(serverSplit[1]) ?? 0 : 0;
      return sevBuild > curBuild;
    } catch (e) {
      debugPrint('Error parsing version strings: $e');
    }
    return false;
  }

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

      // Execute installer in a detached process and shut down current app
      await Process.start(
        installerFile.path,
        [], // Launch installer normally (user follows prompt)
        mode: ProcessStartMode.detached,
      );
      
      // Terminate the Flutter app immediately so the installer can replace files
      exit(0);
    } catch (e) {
      onError('Update failed: $e');
    }
  }
}
