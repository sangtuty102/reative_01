import 'dart:convert';
import 'dart:io';

void main() async {
  final langDir = Directory('assets/lang');
  if (!langDir.existsSync()) {
    print('Error: assets/lang directory not found!');
    return;
  }

  final Map<String, Map<String, dynamic>> nestedTranslations = {};

  final dirs = langDir.listSync().whereType<Directory>();
  for (var dir in dirs) {
    final langCode = dir.path.split(Platform.pathSeparator).last;
    
    final Map<String, dynamic> langData = {};

    final files = dir.listSync().whereType<File>().where((f) => f.path.endsWith('.json'));
    for (var file in files) {
      final content = await file.readAsString();
      final Map<String, dynamic> jsonMap = json.decode(content);
      
      // Deep merge JSON
      langData.addAll(jsonMap);
    }

    nestedTranslations[langCode] = langData;
  }

  // Flatten helper
  Map<String, String> flattenJson(Map<String, dynamic> jsonMap, [String prefix = '']) {
    final Map<String, String> flatMap = {};
    jsonMap.forEach((key, value) {
      final newKey = prefix.isEmpty ? key : '${prefix}_$key';
      if (value is Map<String, dynamic>) {
        flatMap.addAll(flattenJson(value, newKey));
      } else {
        flatMap[newKey] = value.toString();
      }
    });
    return flatMap;
  }

  final Map<String, Map<String, String>> flatTranslations = {};
  final Set<String> allKeys = {};

  // 1. Output en.json and vi.json and prepare flat maps
  for (var entry in nestedTranslations.entries) {
    final langCode = entry.key; // en, vi
    final nestedData = entry.value;

    // Save full nested JSON
    final jsonEncoder = JsonEncoder.withIndent('  ');
    await File('assets/lang/$langCode.json').writeAsString(jsonEncoder.convert(nestedData));

    // Map language code for GetX (en -> en_US, vi -> vi_VN)
    String getxLangCode = langCode;
    if (langCode == 'en') getxLangCode = 'en_US';
    if (langCode == 'vi') getxLangCode = 'vi_VN';

    // Flatten
    final flatMap = flattenJson(nestedData);
    flatTranslations[getxLangCode] = flatMap;
    allKeys.addAll(flatMap.keys);
  }

  // Helper to convert snake_case to camelCase
  String toCamelCase(String str) {
    List<String> parts = str.split('_');
    if (parts.isEmpty) return str;
    String result = parts[0];
    for (int i = 1; i < parts.length; i++) {
      if (parts[i].isEmpty) continue;
      result += parts[i][0].toUpperCase() + parts[i].substring(1);
    }
    return result;
  }

  // Combine all outputs into a single file
  final outBuffer = StringBuffer();
  outBuffer.writeln('/// Cung cấp dữ liệu đa ngôn ngữ cho toàn bộ ứng dụng.');
  outBuffer.writeln('/// File này được sinh tự động bởi scripts/gen_lang.dart');
  outBuffer.writeln('/// Vui lòng KHÔNG sửa trực tiếp file này.');
  outBuffer.writeln('');
  outBuffer.writeln('import \'package:get/get.dart\';');
  outBuffer.writeln('');
  
  // 1. AppTranslations
  outBuffer.writeln('class AppTranslations extends Translations {');
  outBuffer.writeln('  @override');
  outBuffer.writeln('  Map<String, Map<String, String>> get keys => {');
  for (var lang in flatTranslations.keys) {
    outBuffer.writeln('        \'$lang\': Locales.$lang,');
  }
  outBuffer.writeln('      };');
  outBuffer.writeln('}');
  outBuffer.writeln('');

  // 2. Locales Maps
  outBuffer.writeln('class Locales {');
  for (var entry in flatTranslations.entries) {
    final lang = entry.key; // e.g. en_US
    final data = entry.value;
    outBuffer.writeln('  static const $lang = {');
    data.forEach((key, value) {
      final safeValue = value.replaceAll('\'', '\\\'').replaceAll('\$', '\\\$');
      outBuffer.writeln('    \'$key\': \'$safeValue\',');
    });
    outBuffer.writeln('  };');
  }
  outBuffer.writeln('}');
  outBuffer.writeln('');

  // 3. LocaleKeys
  outBuffer.writeln('abstract class LocaleKeys {');
  final sortedKeys = allKeys.toList()..sort();
  for (var key in sortedKeys) {
    final camelKey = toCamelCase(key);
    outBuffer.writeln('  static const $camelKey = \'$key\';');
  }
  outBuffer.writeln('}');

  // Save to lib/generated/locales.g.dart
  final genDir = Directory('lib/generated');
  if (!genDir.existsSync()) {
    genDir.createSync(recursive: true);
  }
  await File('lib/generated/locales.g.dart').writeAsString(outBuffer.toString());

  // Try formatting the file
  try {
    Process.runSync('dart', ['format', 'lib/generated/locales.g.dart']);
  } catch (e) {
    // ignore
  }

  print('Successfully generated single file: lib/generated/locales.g.dart');
}
