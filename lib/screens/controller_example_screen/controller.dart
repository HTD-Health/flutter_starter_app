import 'package:flutter/material.dart';

class CounterScreenController extends ChangeNotifier {
  final int initialValue;

  int _value;
  int get value => _value;

  CounterScreenController([this.initialValue = 0]) : _value = initialValue;

  void increment() {
    _value++;

    notifyListeners();
  }

  void decrement() {
    _value--;

    notifyListeners();
  }

  void reset() {
    _value = initialValue;

    notifyListeners();
  }
}
