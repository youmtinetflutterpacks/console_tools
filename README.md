
## Usage


```dart
import 'package:console_tools/console_tools.dart';

void main() {
  for (var element in ConsoleColors.values) {
    Console.log(
      element.name,
      color: element,
      consoleStyle: ConsoleStyles.normal,
    );
  }
  Console.log('awesome: Console log normal 002', consoleStyle: ConsoleStyles.clineote);
  Console.log('awesome: Console log normal 003', consoleStyle: ConsoleStyles.clineote);
  Console.log('awesome: Console log normal 004', consoleStyle: ConsoleStyles.clineote);
  Console.log('awesome: Console log normal', consoleStyle: ConsoleStyles.bold);
  Console.log('awesome: Console log', consoleStyle: ConsoleStyles.bold);
  Console.log('awesome: Console log clineote', consoleStyle: ConsoleStyles.clineote);
  Console.log('awesome: Console log clineoteFast', consoleStyle: ConsoleStyles.clineoteFast);
  Console.log('awesome: Console log italic', consoleStyle: ConsoleStyles.italic);
  Console.log('awesome: Console log lineThrought', consoleStyle: ConsoleStyles.lineThrought);
  Console.log('awesome: Console log normal2', consoleStyle: ConsoleStyles.normal2);
  Console.log('awesome: Console log opacity', consoleStyle: ConsoleStyles.opacity);
  Console.log('awesome: Console log underline', consoleStyle: ConsoleStyles.underline);
}

```

