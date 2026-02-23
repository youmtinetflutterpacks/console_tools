import 'dart:async';
import 'dart:convert';

/// Severity levels used by [Console] to categorize log messages.
///
/// Each level maps to a distinct ANSI color and icon in the console output:
///
/// | Level     | Color  | Icon |
/// |-----------|--------|------|
/// | [debug]   | grey   | 🐛   |
/// | [info]    | cyan   | ℹ️   |
/// | [success] | green  | ✅   |
/// | [warning] | yellow | ⚠️   |
/// | [error]   | red    | ❌   |
enum LogLevel {
  /// Verbose / debug-only information. Useful during development.
  debug,

  /// General informational messages about normal program flow.
  info,

  /// Confirmation that an operation completed successfully.
  success,

  /// Something unexpected happened but execution can continue.
  warning,

  /// A serious problem that requires immediate attention.
  error,
}

/// A static utility class for structured, colorized console logging.
///
/// [Console] writes formatted log lines to standard output using ANSI escape
/// codes. Each message is prefixed with an optional timestamp, a level icon,
/// and an optional tag, making log output easy to scan at a glance.
///
/// All methods are static — the class cannot be instantiated.
///
/// ## Output format
///
/// ```
/// [HH:mm:ss] <icon> [tag] <message>
/// ```
///
/// ## Example
///
/// ```dart
/// Console.enableColors = true;   // default
/// Console.showTimestamp = true;  // default
///
/// Console.d('Connecting…',  tag: 'DB');
/// Console.i('Server ready', tag: 'HTTP');
/// Console.s('User created');
/// Console.w('Rate limit close', tag: 'API');
/// Console.e('Null pointer',    tag: 'CRASH');
/// Console.json({'status': 'ok'});
/// ```
class Console {
  /// Forwards a message to [i] using [dart:developer]-compatible parameters.
  ///
  /// This method mirrors the signature of `dart:developer`'s `log` function so
  /// that [Console] can be used as a drop-in replacement.  Only [text] and
  /// [name] (mapped to *tag*) are used; the remaining parameters are accepted
  /// for API compatibility but are currently ignored.
  ///
  /// Parameters:
  /// - [text] — the message to log.
  /// - [name] — tag label shown in brackets (defaults to `'logger'`).
  /// - [time], [sequenceNumber], [level], [zone], [error], [stackTrace] —
  ///   unused; kept for `dart:developer` compatibility.
  static void log(
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

  /// Whether ANSI color codes are applied to log output.
  ///
  /// Set to `false` when logging to a file or a terminal that does not support
  /// ANSI escape sequences.
  ///
  /// Defaults to `true`.
  static bool enableColors = true;

  /// Whether a `[HH:mm:ss]` timestamp prefix is prepended to every message.
  ///
  /// Defaults to `true`.
  static bool showTimestamp = true;

  // ANSI reset sequence
  static const _reset = '\x1B[0m';

  // Maps each log level to its ANSI foreground color code
  static const _colors = {
    LogLevel.debug: '\x1B[90m', // grey
    LogLevel.info: '\x1B[36m', // cyan
    LogLevel.success: '\x1B[32m', // green
    LogLevel.warning: '\x1B[33m', // yellow
    LogLevel.error: '\x1B[31m', // red
  };

  // Maps each log level to its display icon
  static const _icons = {
    LogLevel.debug: '🐛',
    LogLevel.info: 'ℹ️',
    LogLevel.success: '✅',
    LogLevel.warning: '⚠️',
    LogLevel.error: '❌',
  };

  /// Logs a **debug** message (grey 🐛).
  ///
  /// Use for verbose, developer-only information that is not relevant in
  /// production.
  ///
  /// ```dart
  /// Console.d('Socket opened', tag: 'WS');
  /// ```
  ///
  /// - [message] — the value to print; `toString()` is called automatically.
  /// - [tag] — optional label shown in brackets, e.g. `[WS]`.
  static void d(Object? message, {String? tag}) =>
      _log(LogLevel.debug, message, tag);

  /// Logs an **info** message (cyan ℹ️).
  ///
  /// Use for general informational messages about normal application flow.
  ///
  /// ```dart
  /// Console.i('Server started on port 8080', tag: 'HTTP');
  /// ```
  ///
  /// - [message] — the value to print.
  /// - [tag] — optional label shown in brackets.
  static void i(Object? message, {String? tag}) =>
      _log(LogLevel.info, message, tag);

  /// Logs a **success** message (green ✅).
  ///
  /// Use to confirm that an operation completed without errors.
  ///
  /// ```dart
  /// Console.s('Payment processed', tag: 'BILLING');
  /// ```
  ///
  /// - [message] — the value to print.
  /// - [tag] — optional label shown in brackets.
  static void s(Object? message, {String? tag}) =>
      _log(LogLevel.success, message, tag);

  /// Logs a **warning** message (yellow ⚠️).
  ///
  /// Use when something unexpected occurred but execution can safely continue.
  ///
  /// ```dart
  /// Console.w('Cache miss — falling back to network', tag: 'CACHE');
  /// ```
  ///
  /// - [message] — the value to print.
  /// - [tag] — optional label shown in brackets.
  static void w(Object? message, {String? tag}) =>
      _log(LogLevel.warning, message, tag);

  /// Logs an **error** message (red ❌).
  ///
  /// Use for serious problems that require immediate attention or indicate a
  /// failure in program logic.
  ///
  /// ```dart
  /// Console.e('Unhandled exception: $e', tag: 'CRASH');
  /// ```
  ///
  /// - [message] — the value to print.
  /// - [tag] — optional label shown in brackets.
  static void e(Object? message, {String? tag}) =>
      _log(LogLevel.error, message, tag);

  /// Pretty-prints a JSON-encodable [jsonObj] at the [LogLevel.debug] level.
  ///
  /// The object is serialized with a two-space indent so nested structures are
  /// easy to read in the console.
  ///
  /// ```dart
  /// Console.json({'user': 'Younes', 'role': 'developer'}, tag: 'AUTH');
  /// ```
  ///
  /// - [jsonObj] — any value accepted by [JsonEncoder] (Map, List, num, etc.).
  /// - [tag] — optional label shown in brackets.
  static void json(Object jsonObj, {String? tag}) {
    final encoder = const JsonEncoder.withIndent('  ');
    final pretty = encoder.convert(jsonObj);
    _log(LogLevel.debug, pretty, tag);
  }

  /// Internal method that formats and prints a single log line.
  ///
  /// Builds the output string from the optional timestamp, the level icon,
  /// an optional tag, and the message, then wraps it with ANSI color codes
  /// if [enableColors] is `true`.
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

  /// Returns the current wall-clock time formatted as `[HH:mm:ss]`.
  static String _timeNow() {
    final now = DateTime.now();
    return '[${now.hour.toString().padLeft(2, '0')}:'
        '${now.minute.toString().padLeft(2, '0')}:'
        '${now.second.toString().padLeft(2, '0')}]';
  }
}
