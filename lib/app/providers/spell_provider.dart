import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class SpellProvider extends ChangeNotifier {
  int _spellIndex = 50;
  List<Map<String, dynamic>> _spells = [];
  List<Map<String, dynamic>> get spells => _spells;
  
  //recebe MAP de spells de um arquvio json
  void initWithFifitySpells() async {
    String contents = await rootBundle.loadString('assets/json/spells_pt.json');
    List<dynamic> spells = jsonDecode(contents);
    _spells = List<Map<String, dynamic>>.from(spells.take(50).toList());

    notifyListeners();
  }


  void loadThirtySpells() async {
    String contents = await rootBundle.loadString('assets/json/spells_pt.json');
    List<dynamic> spells = jsonDecode(contents);

    int end = (_spellIndex + 30 < spells.length) ? _spellIndex + 30 : spells.length;
    _spells.addAll(List<Map<String, dynamic>>.from(spells.getRange(_spellIndex, end).toList()));
    _spellIndex = end;

    notifyListeners();
  }
}