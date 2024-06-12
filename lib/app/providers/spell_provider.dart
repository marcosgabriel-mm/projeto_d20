import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class SpellProvider extends ChangeNotifier {
  int _spellIndex = 50;
  List<Map<String, dynamic>> _spells = [];
  List<Map<String, dynamic>> get spells => _spells;
  Map<dynamic, dynamic> spellFilters = {
    "Classes": ["Bárbaro", "Bardo", "Clérigo", "Druida", "Feiticeiro", "Guerreiro", "Ladino", "Mago", "Monge", "Paladino", "Ranger"],
    "Níveis": ["Truque", "Nível 1", "Nível 2", "Nível 3", "Nível 4", "Nível 5", "Nível 6", "Nível 7", "Nível 8", "Nível 9"],
    "Livros": ["Player´s Handbook", "Xanathar´s Guide to Everything", "Tasha´s Cauldron of Everything", ],
    "Rituais": ["Sim", "Não"],
    "Componentes": ["V", "S", "M"],
    // "Alcance": ["Toque", "Curto", "Médio", "Longo", "Ilimitado"],
  };
  
  void initWithFifitySpells() async {

    _spells.clear();
    _spellIndex = 50;

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

  void searchSpell(String value) async {

    String contents = await rootBundle.loadString('assets/json/spells_pt.json');
    List<dynamic> spells = jsonDecode(contents);
    
    _spells.clear();

    for (var spell in spells) {
      if (spell['name'].toString().toLowerCase().contains(value.toLowerCase())) {
        _spells.add(spell);
      }
    }
    notifyListeners();
  }

  void searchSpellByFilter(List<String> filters) async {

    String contents = await rootBundle.loadString('assets/json/spells_pt.json');
    List<dynamic> spells = jsonDecode(contents);
    
    _spells.clear();

    for (var filter in filters) {
      for (var spell in spells) {
        for (var key in spell.keys) {
          if (spell[key].toString().toLowerCase().contains(filter.toLowerCase())) {
            _spells.add(spell);
          }
        }
      }
    }
    notifyListeners();
  }
}