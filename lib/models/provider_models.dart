import 'package:flutter/material.dart';

class OpacityListItem extends ChangeNotifier {
  int _index = 0;
  bool _trigger = false;

  int get index => _index;
  bool get trigger => _trigger;

  set index(int index) {
    _index = index;
    notifyListeners();
  }
  set trigger(bool trigger) {
    _trigger = trigger;
    notifyListeners();
  }
}

class BookingItemCount extends ChangeNotifier {
  int _count = 1;

  int get count => _count;
  set count(int count) {
    _count = count;
    notifyListeners();
  }
}
