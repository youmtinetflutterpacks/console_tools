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
    dynamic text, {
    ConsoleColors color = ConsoleColors.white,
    ConsoleStyles consoleStyle = ConsoleStyles.normal,
  }) {
    var printtext = '\x1B[${color.index + 30}m $text\x1B[${consoleStyle.index + 0}m\x1B[m';
    var xcolor = '\x1B[${color.index + 30}m\x1B[${consoleStyle.index + 0}m\x1B[m';
    print(xcolor);
    print(printtext);
    print(xcolor);
  }
}
