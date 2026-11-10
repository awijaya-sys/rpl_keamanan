import 'package:flutter/foundation.dart';

/// Level log yang tersedia.
enum LogLevel { debug, info, warning, error }

/// Logger terstruktur sederhana.
///
/// Log hanya ditampilkan di mode debug ([kDebugMode]) dan pesan
/// yang berisi data sensitif (token, password, API key) disamarkan.
class Logger {
  static final RegExp _sensitive = RegExp(
    r'(token|password|passwd|api[_-]?key|secret|pin)\s*[:=]\s*\S+',
    caseSensitive: false,
  );

  /// Mengganti nilai data sensitif pada [message] dengan `***`.
  static String redact(String message) {
    return message.replaceAllMapped(_sensitive, (m) {
      final key = m.group(1);
      return '$key=***';
    });
  }

  static void _log(LogLevel level, String message, [String tag = 'APP']) {
    if (!kDebugMode) return;
    final time = DateTime.now().toIso8601String();
    debugPrint('[$time] [${level.name.toUpperCase()}] [$tag] ${redact(message)}');
  }

  /// Log level debug.
  static void debug(String message, {String tag = 'APP'}) =>
      _log(LogLevel.debug, message, tag);

  /// Log level info.
  static void info(String message, {String tag = 'APP'}) =>
      _log(LogLevel.info, message, tag);

  /// Log level warning.
  static void warning(String message, {String tag = 'APP'}) =>
      _log(LogLevel.warning, message, tag);

  /// Log level error.
  static void error(String message, {String tag = 'APP'}) =>
      _log(LogLevel.error, message, tag);
}
