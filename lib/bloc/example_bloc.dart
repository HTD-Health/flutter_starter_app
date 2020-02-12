import 'dart:ui';

import 'package:flutter/foundation.dart';

class Item {
  final Color color;

  const Item(this.color);
}

class ExampleBloc extends ChangeNotifier {
  final List<Item> _items = [];

  List<Item> get items => _items;

  void addItem(Item item) {
    _items.add(item);
    notifyListeners();
    throw Exception();
  }

  void removeAt(int index) {
    if (_items.length > index) {
      _items.removeAt(index);
      notifyListeners();
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
