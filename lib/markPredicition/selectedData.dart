import 'package:flutter/material.dart';

class Counter extends ChangeNotifier {
  List<int> _markofmodules = [0, 0, 0, 0, 0, 0];

  void increamentCounter(int module, int mark) {
    _markofmodules[module] += mark;
    notifyListeners();
  }

  int getmarks(int module) {
    return _markofmodules[module];
  }

  void resetMarks(int module) {
    _markofmodules[module] = 0;
    // debugPrint(_markofmodules.toString());
  }

  void resetAllMarks() {
    for (int i = 0; i < 6; i++) {
      _markofmodules[i] = 0;
    }
  }

  int getsum() {
    int sum = 0;
    for (int i = 0; i < 6; i++) {
      sum += _markofmodules[i];
    }
    return sum;
  }
}
