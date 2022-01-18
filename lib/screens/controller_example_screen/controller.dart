import 'package:flutter_starter_app/utils/controlled/controlled.dart';

class CounterScreenController extends Controller {
  final int initialValue;

  int _value;
  int get value => _value;

  CounterScreenController([this.initialValue = 0]) : _value = initialValue;

  void increment() {
    _value++;

    update();
  }

  void decrement() {
    _value--;

    update();
  }

  void reset() {
    _value = initialValue;

    update();
  }
}
