<div align="center">

<div align="center">
    <img src="https://raw.githubusercontent.com/youmtinetflutterpacks/console_tools/refs/heads/main/assets/readme_banner.png" alt="console_tools logo"/>
</div>

[![pub package](https://img.shields.io/pub/v/console_tools.svg)](https://pub.dev/packages/console_tools)
[![pub likes](https://img.shields.io/pub/likes/console_tools.svg)](https://pub.dev/packages/console_tools/score)
[![pub points](https://img.shields.io/pub/points/console_tools.svg?color=blue)](https://pub.dev/packages/console_tools/score)
[![platform](https://img.shields.io/badge/platform-flutter-blue)](https://flutter.dev)

[![GitHub stars](https://img.shields.io/github/stars/youmtinetflutterpacks/console_tools.svg?style=flat&logo=github&colorB=&label=Stars)](https://github.com/youmtinetflutterpacks/console_tools/stargazers)
[![GitHub issues](https://img.shields.io/github/issues/youmtinetflutterpacks/console_tools.svg?style=flat&logo=github&colorB=&label=Issues)](https://github.com/youmtinetflutterpacks/console_tools/issues)
[![GitHub license](https://img.shields.io/github/license/youmtinetflutterpacks/console_tools.svg?style=flat&logo=github&colorB=&label=License)](https://github.com/youmtinetflutterpacks/console_tools/blob/main/LICENSE)
[![GitHub last commit](https://img.shields.io/github/last-commit/youmtinetflutterpacks/console_tools.svg?style=flat&logo=github&colorB=&label=Last%20Commit)](https://github.com/youmtinetflutterpacks/console_tools/commits/main)


[![Build status](https://github.com/youmtinetflutterpacks/console_tools/workflows/publish_pub_dev/badge.svg?style=flat&logo=github&colorB=&label=Build)](https://github.com/youmtinetflutterpacks/console_tools)
</div>

A lightweight Dart console logger with ANSI color support, log-level icons, timestamps, and JSON pretty-printing.

---

## Features

- **Five log levels**: `debug`, `info`, `success`, `warning`, `error`
- **ANSI color-coded output** (grey, cyan, green, yellow, red)
- **Icons** for each level: 🐛 ℹ️ ✅ ⚠️ ❌
- **Optional tag** to identify the source of a log entry
- **Timestamp** prefix (`[HH:mm:ss]`)
- **JSON pretty-printing** with indentation
- Global toggles: `Console.enableColors` and `Console.showTimestamp`

---

## Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  console_tools: ^2.0.0
```

Then run:

```sh
dart pub get
```

---

## Usage

```dart
import 'package:console_tools/console_tools.dart';

void main() {
  Console.d("Debug message");
  Console.i("Info message", tag: "AUTH");
  Console.s("Login successful");
  Console.w("API slow response");
  Console.e("Crash detected");

  Console.json({
    "user": "Younes",
    "role": "developer",
  });
}
```

### Sample output

```
[12:34:56] 🐛  Debug message
[12:34:56] ℹ️ [AUTH] Info message
[12:34:56] ✅  Login successful
[12:34:56] ⚠️  API slow response
[12:34:56] ❌  Crash detected
[12:34:56] 🐛  {
  "user": "Younes",
  "role": "developer"
}
```

---

## API Reference

### `Console` class

| Method | Level | Color | Description |
|---|---|---|---|
| `Console.d(msg, {tag})` | debug | grey | Debug information |
| `Console.i(msg, {tag})` | info | cyan | General information |
| `Console.s(msg, {tag})` | success | green | Success confirmation |
| `Console.w(msg, {tag})` | warning | yellow | Non-critical warnings |
| `Console.e(msg, {tag})` | error | red | Errors and exceptions |
| `Console.json(obj, {tag})` | debug | grey | Pretty-prints a JSON object |
| `Console.log(msg, {name})` | info | cyan | Alias for `Console.i` |

### Global settings

```dart
Console.enableColors = false;    // disable ANSI colors (default: true)
Console.showTimestamp = false;   // hide the [HH:mm:ss] prefix (default: true)
```

---

## License

MIT

## 🔗 More Packages

- [Power GeoJSON](https://pub.dev/packages/power_geojson)
- [PopupMenu2](https://pub.dev/packages/popup_menu_2)
- [Flutter Azimuth](https://pub.dev/packages/flutter_azimuth)
- [Map Contextual Menu](https://pub.dev/packages/longpress_popup)

---

## 👨‍💻 Developer Card

<div align="center">
    <img src="https://avatars.githubusercontent.com/u/47449165?v=4" alt="Younes M'rabti avatar" width="120" height="120" style="border-radius: 50%;" />

### Younes M'rabti

📧 Email: [admin@youmti.net](mailto:admin@youmti.net)  
🌐 Website: [youmti.net](https://www.youmti.net/)  
💼 LinkedIn: [younesmrabti1996](https://www.linkedin.com/in/younesmrabti1996/)
</div>
