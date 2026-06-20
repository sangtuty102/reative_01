import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'flavor_config.dart';
import 'services/update_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Fallback initialization if run directly via main.dart
  FlavorConfig.initialize(
    flavor: Flavor.dev,
    apiBaseUrl: 'https://api-dev.reative.com',
    appTitle: 'Reative Dev (Fallback)',
    primaryColor: Colors.teal,
  );

  mainCommon();
}

void mainCommon() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final config = FlavorConfig.instance;
    return MaterialApp(
      title: config.appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: config.primaryColor,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: MyHomePage(title: config.appTitle),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool _isCheckingUpdate = false;
  double _updateProgress = 0.0;
  bool _isDownloading = false;
  String _downloadError = '';
  String _appVersion = '...';

  @override
  void initState() {
    super.initState();
    _loadAppVersion();
    // Check for updates silently on startup
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkUpdates(silent: true);
    });
  }

  Future<void> _loadAppVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        _appVersion = 'v${packageInfo.version}+${packageInfo.buildNumber}';
      });
    } catch (e) {
      setState(() {
        _appVersion = 'v1.0.0';
      });
    }
  }

  Future<void> _checkUpdates({required bool silent}) async {
    if (_isCheckingUpdate) return;
    setState(() {
      _isCheckingUpdate = true;
    });

    try {
      final updateInfo = await UpdateService.checkForUpdate();
      if (!mounted) return;

      if (updateInfo != null) {
        _showUpdateDialog(updateInfo);
      } else {
        if (!silent) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Ứng dụng đã ở phiên bản mới nhất!')),
          );
        }
      }
    } catch (e) {
      if (!silent) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi kiểm tra cập nhật: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isCheckingUpdate = false;
        });
      }
    }
  }

  void _showUpdateDialog(UpdateInfo updateInfo) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: Text('Có Phiên Bản Mới! (v${updateInfo.serverVersion})'),
              content: SizedBox(
                width: 300,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (updateInfo.changelog.isNotEmpty) ...[
                      const Text(
                        'Tính năng mới:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(updateInfo.changelog),
                      const SizedBox(height: 16),
                    ],
                    if (_isDownloading) ...[
                      const Text('Đang tải bản cập nhật...'),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(value: _updateProgress),
                      const SizedBox(height: 4),
                      Text(
                        '${(_updateProgress * 100).toStringAsFixed(0)}%',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ] else if (_downloadError.isNotEmpty) ...[
                      Text(
                        _downloadError,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ] else ...[
                      const Text('Bạn có muốn tải xuống và cài đặt bản cập nhật ngay bây giờ?'),
                    ],
                  ],
                ),
              ),
              actions: [
                if (!_isDownloading) ...[
                  TextButton(
                    onPressed: () {
                      _downloadError = '';
                      Navigator.of(context).pop();
                    },
                    child: const Text('Bỏ qua'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setDialogState(() {
                        _isDownloading = true;
                        _updateProgress = 0.0;
                        _downloadError = '';
                      });
                      _startDownload(updateInfo.downloadUrl, setDialogState);
                    },
                    child: const Text('Cập nhật'),
                  ),
                ],
              ],
            );
          },
        );
      },
    );
  }

  void _startDownload(String url, StateSetter setDialogState) {
    UpdateService.downloadAndInstall(
      url: url,
      onProgress: (progress) {
        setDialogState(() {
          _updateProgress = progress;
        });
      },
      onError: (error) {
        setDialogState(() {
          _isDownloading = false;
          _downloadError = error;
        });
      },
    );
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = FlavorConfig.instance;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primaryContainer,
        title: Text(
          widget.title,
          style: TextStyle(
              color: colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Premium Flavor Info Card
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        color: colorScheme.surfaceContainerHighest,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: config.primaryColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  'FLAVOR: ${config.flavor.name.toUpperCase()}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              _buildInfoRow(context, 'App Name:', config.appTitle),
                              const Divider(height: 24),
                              _buildInfoRow(
                                  context, 'API Endpoint:', config.apiBaseUrl),
                              const Divider(height: 24),
                              TextButton.icon(
                                onPressed: _isCheckingUpdate
                                    ? null
                                    : () => _checkUpdates(silent: false),
                                icon: _isCheckingUpdate
                                    ? const SizedBox(
                                        width: 16,
                                        height: 16,
                                        child: CircularProgressIndicator(
                                            strokeWidth: 2),
                                      )
                                    : const Icon(Icons.update),
                                label: const Text('Kiểm tra cập nhật'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Text(
                        'You have pushed the button this many times:',
                        style: TextStyle(color: colorScheme.onSurfaceVariant),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '$_counter',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Text(
                        'Phiên bản hiện tại: $_appVersion',
                        style: TextStyle(
                          fontSize: 12,
                          color: colorScheme.onSurfaceVariant.withOpacity(0.5),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.onPrimaryContainer,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

