/// A lightweight, colorized console logger for Dart and Flutter applications.
///
/// This library provides the [Console] class for structured, leveled logging
/// with ANSI color support, timestamps, optional tags, and pretty-printed JSON.
///
/// ## Quick start
///
/// ```dart
/// import 'package:console_tools/console_tools.dart';
///
/// void main() {
///   Console.d('Debug message');                       // grey
///   Console.i('Server started', tag: 'HTTP');         // cyan
///   Console.s('Login successful');                    // green
///   Console.w('Slow API response');                   // yellow
///   Console.e('Unhandled exception');                 // red
///   Console.json({'user': 'Younes', 'role': 'dev'}); // pretty JSON
/// }
/// ```
///
/// Color output can be disabled globally:
///
/// ```dart
/// Console.enableColors = false;
/// ```
///
/// Timestamps can be hidden:
///
/// ```dart
/// Console.showTimestamp = false;
/// ```
library console_tools;

export 'src/console_tools_base.dart';
