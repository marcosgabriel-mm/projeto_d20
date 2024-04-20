import 'package:flutter/material.dart';

class D20Provider extends ChangeNotifier {
  bool _toogleBottomBar = true;
  bool _isSelectionMode = false;
  int _currentIndex = 0;

  bool get toogleBottomBar => _toogleBottomBar;
  bool get isSelectionMode => _isSelectionMode;
  int get currentIndex => _currentIndex;

  void turnOffOrOnBottomBar() {
    _toogleBottomBar = !_toogleBottomBar;
    notifyListeners();
  }

  void toogleSelectionMode() {
    _isSelectionMode = !_isSelectionMode;
    notifyListeners();
  }

  void updateBottomMenuState(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
