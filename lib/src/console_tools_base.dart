import 'dart:async';
import 'dart:developer' as dev;

enum ConsoleStyles {
  normal,
  bold,
  opacity,
  italic,
  underline,
  clineote,
  clineoteFast,
  none,
  normal2,
  lineThrought,
}

enum ConsoleColors {
  /// #000000 black
  black,

  /// #c42654 Rose Red
  roseRed,

  /// #4c892d Sap Green
  greenSap,

  /// #94b428 Citron
  citron,

  /// #6a7ec8 Violet-Blue
  crayola,

  /// #8c6bc8 Middle Blue Purple
  middleBluePurple,

  /// #
  teal,

  /// #
  white,
}

class Console {
  static log(
    Object? text, {
    ConsoleColors color = ConsoleColors.white,
    ConsoleStyles consoleStyle = ConsoleStyles.normal,
    String name = 'logger',
    DateTime? time,
    int? sequenceNumber,
    int level = 0,
    Zone? zone,
    Object? error,
    StackTrace? stackTrace,
  }) {
    var printtext =
        '\x1B[${color.index + 30}m$text\x1B[${consoleStyle.index}m\x1B[m';
    dev.log(
      printtext,
      name: name,
      error: error,
      level: level,
      sequenceNumber: sequenceNumber,
      stackTrace: stackTrace,
      time: time,
      zone: zone,
    );
  }
}
