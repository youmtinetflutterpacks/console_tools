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
