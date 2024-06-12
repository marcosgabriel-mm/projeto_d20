import 'package:flutter/material.dart';

class FilterProvider extends ChangeNotifier {
  
  List<String> selected = [];
  void selectFilter(String filter) {
    if (!selected.contains(filter)) {
      selected.add(filter);
    } else {
      selected.remove(filter);
    }
    notifyListeners();
  }

  void clearFilters() {
    selected.clear();
    notifyListeners();
  }
}