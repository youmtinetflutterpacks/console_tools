import 'dart:async';
import 'dart:convert';

enum LogLevel { debug, info, success, warning, error }

class Console {
  static log(
    Object? text, {
    String name = 'logger',
    DateTime? time,
    int? sequenceNumber,
    int level = 0,
    Zone? zone,
    Object? error,
    StackTrace? stackTrace,
  }) {
    i(text, tag: name);
  }

  Console._();

  static bool enableColors = true;
  static bool showTimestamp = true;

  // ANSI colors
  static const _reset = '\x1B[0m';

  static const _colors = {
    LogLevel.debug: '\x1B[90m', // grey
    LogLevel.info: '\x1B[36m', // cyan
    LogLevel.success: '\x1B[32m', // green
    LogLevel.warning: '\x1B[33m', // yellow
    LogLevel.error: '\x1B[31m', // red
  };

  static const _icons = {
    LogLevel.debug: '🐛',
    LogLevel.info: 'ℹ️',
    LogLevel.success: '✅',
    LogLevel.warning: '⚠️',
    LogLevel.error: '❌',
  };

  static void d(Object? message, {String? tag}) =>
      _log(LogLevel.debug, message, tag);

  static void i(Object? message, {String? tag}) =>
      _log(LogLevel.info, message, tag);

  static void s(Object? message, {String? tag}) =>
      _log(LogLevel.success, message, tag);

  static void w(Object? message, {String? tag}) =>
      _log(LogLevel.warning, message, tag);

  static void e(Object? message, {String? tag}) =>
      _log(LogLevel.error, message, tag);

  static void json(Object jsonObj, {String? tag}) {
    final encoder = const JsonEncoder.withIndent('  ');
    final pretty = encoder.convert(jsonObj);
    _log(LogLevel.debug, pretty, tag);
  }

  static void _log(LogLevel level, Object? message, String? tag) {
    final time = showTimestamp ? _timeNow() : '';
    final icon = _icons[level];
    final tagPart = tag != null ? '[$tag]' : '';

    final base = '$time $icon $tagPart $message';

    if (!enableColors) {
      print(base);
      return;
    }

    final color = _colors[level];
    print('$color$base$_reset');
  }

  static String _timeNow() {
    final now = DateTime.now();
    return '[${now.hour.toString().padLeft(2, '0')}:'
        '${now.minute.toString().padLeft(2, '0')}:'
        '${now.second.toString().padLeft(2, '0')}]';
  }
}
