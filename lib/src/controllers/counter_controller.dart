import 'package:mvc_pattern/mvc_pattern.dart';

class CounterController extends ControllerMVC {
  late int value;

  CounterController() {
    value = 0;
  }

  void increment() {
    value++;
    refresh();
  }

  void decrement() {
    value--;
    refresh();
  }
}
