import 'package:flutter/material.dart';

class Controller extends ChangeNotifier {
  int currentIndex = 0;
  void increament(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
