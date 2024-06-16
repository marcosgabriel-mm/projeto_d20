import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;

import 'package:d20_project/app/models/character.dart';
import 'package:d20_project/app/providers/files_provider.dart';

class CharacterProvider extends ChangeNotifier {

  late Character _character = Character(
    name: "Nome",
    race: "Raça",
    classType: "Classe",
    level: 1,
    experience: 0,
    maxHitPoints: 0,
    currentHitPoints: 0,
    description: "",
    primaryStats: {
      'Inspiração': 0,
      'Bônus de Proficiência': 0,
      'Classe de Armadura': 0,
      'Movimento': 0,
      'Iniciativa': 0,
      'Percepção Passiva': 0,
    },
    stats: {
      'Força': 0,
      'Destreza': 0,
      'Constituição': 0,
      'Inteligência': 0,
      'Sabedoria': 0,
      'Carisma': 0,
    },
    skills: {
      'Atletismo': {
        'valor': 0,
        'atributo': 'Força',
        'proficiente': false
      },
      'Acrobacia': {
        'valor': 0,
        'atributo': 'Destreza',
        'proficiente': false
      },
      'Furtividade': {
        'valor': 0,
        'atributo': 'Destreza',
        'proficiente': false
      },
      'Prestidigitação': {
        'valor': 0,
        'atributo': 'Destreza',
        'proficiente': false
      },
      'Arcanismo': {
        'valor': 0,
        'atributo': 'Inteligência',
        'proficiente': false
      },
      'Investigacao': {
        'valor': 0,
        'atributo': 'Inteligência',
        'proficiente': false
      },
      'Historia': {
        'valor': 0,
        'atributo': 'Inteligência',
        'proficiente': false
      },
      'Natureza': {
        'valor': 0,
        'atributo': 'Inteligência',
        'proficiente': false
      },
      'Religiao': {
        'valor': 0,
        'atributo': 'Inteligência',
        'proficiente': false
      },
      'Intuição': {
        'valor': 0,
        'atributo': 'Sabedoria',
        'proficiente': false
      },
      'Sobrevivencia': {
        'valor': 0,
        'atributo': 'Sabedoria',
        'proficiente': false
      },
      'Medicina': {
        'valor': 0,
        'atributo': 'Sabedoria',
        'proficiente': false
      },
      'Percepcao': {
        'valor': 0,
        'atributo': 'Sabedoria',
        'proficiente': false
      },
      'Lidar /c animais': {
        'valor': 0,
        'atributo': 'Sabedoria',
        'proficiente': false
      },
      'Atuação': {
        'valor': 0,
        'atributo': 'Carisma',
        'proficiente': false
      },
      'Persuasão': {
        'valor': 0,
        'atributo': 'Carisma',
        'proficiente': false
      },
      'Intimidação': {
        'valor': 0,
        'atributo': 'Carisma',
        'proficiente': false
      },
      'Enganação': {
        'valor': 0,
        'atributo': 'Carisma',
        'proficiente': false
      }
    }
  );
  
  Character characterDefault = Character(
    name: "Nome",
    race: "Raça",
    classType: "Classe",
    description: "",
    level: 1,
    experience: 0,
    maxHitPoints: 0,
    currentHitPoints: 0,
    primaryStats: {
      'Inspiração': 0,
      'Bônus de Proficiência': 0,
      'Classe de Armadura': 0,
      'Movimento': 0,
      'Iniciativa': 0,
      'Percepção Passiva': 0,
    },
    stats: {
      'Força': 0,
      'Destreza': 0,
      'Constituição': 0,
      'Inteligência': 0,
      'Sabedoria': 0,
      'Carisma': 0,
    },
    skills: {
      'Atletismo': {
        'valor': 0,
        'atributo': 'Força',
        'proficiente': false
      },
      'Acrobacia': {
        'valor': 0,
        'atributo': 'Destreza',
        'proficiente': false
      },
      'Furtividade': {
        'valor': 0,
        'atributo': 'Destreza',
        'proficiente': false
      },
      'Prestidigitação': {
        'valor': 0,
        'atributo': 'Destreza',
        'proficiente': false
      },
      'Arcanismo': {
        'valor': 0,
        'atributo': 'Inteligência',
        'proficiente': false
      },
      'Investigacao': {
        'valor': 0,
        'atributo': 'Inteligência',
        'proficiente': false
      },
      'Historia': {
        'valor': 0,
        'atributo': 'Inteligência',
        'proficiente': false
      },
      'Natureza': {
        'valor': 0,
        'atributo': 'Inteligência',
        'proficiente': false
      },
      'Religiao': {
        'valor': 0,
        'atributo': 'Inteligência',
        'proficiente': false
      },
      'Intuição': {
        'valor': 0,
        'atributo': 'Sabedoria',
        'proficiente': false
      },
      'Sobrevivencia': {
        'valor': 0,
        'atributo': 'Sabedoria',
        'proficiente': false
      },
      'Medicina': {
        'valor': 0,
        'atributo': 'Sabedoria',
        'proficiente': false
      },
      'Percepcao': {
        'valor': 0,
        'atributo': 'Sabedoria',
        'proficiente': false
      },
      'Lidar /c animais': {
        'valor': 0,
        'atributo': 'Sabedoria',
        'proficiente': false
      },
      'Atuação': {
        'valor': 0,
        'atributo': 'Carisma',
        'proficiente': false
      },
      'Persuasão': {
        'valor': 0,
        'atributo': 'Carisma',
        'proficiente': false
      },
      'Intimidação': {
        'valor': 0,
        'atributo': 'Carisma',
        'proficiente': false
      },
      'Enganação': {
        'valor': 0,
        'atributo': 'Carisma',
        'proficiente': false
      }
    }
  );

  final assetsRoutes = [
    {
        "Atletismo": "assets/svg/skills/atletism.svg",
        "Acrobacia": "assets/svg/skills/acrobatics.svg",
        "Furtividade": "assets/svg/skills/stealth.svg",
        "Prestidigitação": "assets/svg/skills/sleight-of-hand.svg",
        "Arcanismo": "assets/svg/skills/arcana.svg",
        "Investigacao": "assets/svg/skills/investigation.svg",
        "Historia": "assets/svg/skills/history.svg",
        "Natureza": "assets/svg/skills/nature.svg",
        "Religiao": "assets/svg/skills/religion.svg",
        "Intuição": "assets/svg/skills/insight.svg",
        "Sobrevivencia": "assets/svg/skills/survival.svg",
        "Medicina": "assets/svg/skills/medicine.svg",
        "Percepcao": "assets/svg/skills/perception.svg",
        "Lidar /c animais": "assets/svg/skills/animal-handling.svg",
        "Atuação": "assets/svg/skills/performance.svg",
        "Persuasão": "assets/svg/skills/persuasion.svg",
        "Intimidação": "assets/svg/skills/intimidation.svg",
        "Enganação": "assets/svg/skills/deception.svg"
    },
    {
        "Inspiração": "assets/svg/character/inspiration.svg",
        "Bônus de Proficiência": "assets/svg/character/proeficiency_bonus.svg",
        "Classe de Armadura": "assets/svg/character/cd.svg",
        "Movimento": "assets/svg/character/moviment.svg",
        "Iniciativa": "assets/svg/character/initiatives.svg",
        "Percepção Passiva": "assets/svg/character/passive_perception.svg"
    },
    {
      // "Equipamentos": "assets/svg/character/swords-emblem.svg",
      "Mochila": "assets/svg/character/backpack.svg",
      "Grimório": "assets/svg/character/grimory.svg"
    }
  ];

  List<List<String>> get listOfCharacters => _listOfCharacters;
  List<int> get indexesSelected => _indexesSelected;

  List<List<String>> _listOfCharacters = [];
  Character get character => _character;
  List<int> _indexesSelected = [];



  void addIndexSelected(int index) {
    _indexesSelected.add(index);
    debugPrint(_indexesSelected.toString());
    notifyListeners();
  }

  void removeIndexSelected(int index) {
    _indexesSelected.remove(index);
    debugPrint(_indexesSelected.toString());
    notifyListeners();
  }

  void selectOrUnselectAll() {
    int quantity = _listOfCharacters.length;
    if (_indexesSelected.length == quantity) {
      _indexesSelected.clear();
    } else {
      for (int index = 0; index < quantity; index++) {
        if (!_indexesSelected.contains(index)) {
          _indexesSelected.add(index);
        }
      }
    }
    notifyListeners();
  }

  bool areEveryoneSelected() {
    int quantity = _listOfCharacters.length;
    if (_indexesSelected.length == quantity) {
      return true;
    }
    return false;
  }

  loadCharacter(Map<String, dynamic> json) {

    Map<String, dynamic> statsMap = json['stats'];
    Map<String, int>? stats = statsMap.map((key, value) => MapEntry(key, int.tryParse(value.toString()) ?? 0));

    Map<String, dynamic> primaryStatsMap = json['primaryStats'];
    Map<String, int>? primaryStats = primaryStatsMap.map((key, value) => MapEntry(key, int.tryParse(value.toString()) ?? 0));

    _character = Character(
      name: json['name'],
      race: json['race'],
      classType: json['classType'],
      level: json['level'],
      experience: json['experience'],
      description: json['description'],
      maxHitPoints: json['maxHitPoints'],
      currentHitPoints: json['currentHitPoints'],
      primaryStats:  primaryStats,
      stats: stats,
      skills: json['skills']
    );

    notifyListeners();
  }

  set character(Character character) {
    _character = character;
    notifyListeners();
  }

  calcutateModificator(int atributeValue) {

    if (atributeValue >= 31 || atributeValue <= 0) {
      return 0;
    }

    for (int index = 2; index < 31; index++) {
      if (atributeValue == 1) {
        return -5;
      }

      if (atributeValue == 30) {
        return 10;
      }
      
      if (atributeValue == index) {
        return (index/2).floor()-5;
      }
    }
    notifyListeners();
  }

  calculateLevel(int experience){
    if (experience < 300) {
      return 1;
    }else if (experience < 900) {
      return 2;
    }else if (experience < 2700) {
      return 3;
    }else if (experience < 6500) {
      return 4;
    }else if (experience < 14000) {
      return 5;
    }else if (experience < 23000) {
      return 6;
    }else if (experience < 34000) {
      return 7;
    }else if (experience < 48000) {
      return 8;
    }else if (experience < 64000) {
      return 9;
    }else if (experience < 85000) {
      return 10;
    }else if (experience < 100000) {
      return 11;
    }else if (experience < 120000) {
      return 12;
    }else if (experience < 140000) {
      return 13;
    }else if (experience < 165000) {
      return 14;
    }else if (experience < 195000) {
      return 15;
    }else if (experience < 225000) {
      return 16;
    }else if (experience < 265000) {
      return 17;
    }else if (experience < 305000) {
      return 18;
    }else if (experience < 355000) {
      return 19;
    }else if (experience > 355000) {
      return 20;
    }
  }

  bool isProeficient(String skillName) {
    Map<String, dynamic>? skill = character.skills[skillName] as Map<String, dynamic>?;
    if (skill?['proficiente'] == true) {
      return true;
    }
    return false;
  }

  toggleProeficient(String skillName) {
    Map<String, dynamic>? skill = character.skills[skillName] as Map<String, dynamic>?;
    skill?['proficiente'] = !skill['proficiente'];
    notifyListeners();
  }

  void autoCompleteProeficiencyModifierFields() {
    for (String key in character.skills.keys) {
      Map<String, dynamic> skill = character.skills[key] as Map<String, dynamic>;
      String atributeModificator = skill['atributo'];

      int modificator = calcutateModificator(character.stats[atributeModificator]!);
      if (skill['proficiente'] == true) {
        skill['valor'] = modificator + character.primaryStats['Bônus de Proficiência']!;
      } else {
        skill['valor'] = modificator;
      }
    } 
    notifyListeners();
  }

  void addProeficiencyModifier(String skillName) {
    Map<String, dynamic> skill = character.skills[skillName] as Map<String, dynamic>;

    if (skill['proficiente'] == true) {
      skill['valor'] += character.primaryStats['Bônus de Proficiência']!;
    } else {
      skill['valor'] -= character.primaryStats['Bônus de Proficiência']!;
    }
    notifyListeners();
  }

  void updateAtributes(String value, int index) {
    int parsedValue;
    if (value.trim().isNotEmpty && int.tryParse(value.trim()) != null) {
      parsedValue = int.parse(value.trim());
    } else {
      parsedValue = 0;
    }
    character.stats[character.stats.keys.elementAt(index)] = parsedValue;
    calcutateModificator(parsedValue);
    notifyListeners();
  }

  void updateLevel(String value) {

    if (value.trim().isNotEmpty && int.tryParse(value.trim()) != null) {
      character.experience = int.parse(value.trim());
    }

    character.level = calculateLevel(character.experience);
    calculateProeficiencyBonus();
    notifyListeners();
  }

  void calculateProeficiencyBonus() {
    character.primaryStats['Bônus de Proficiência'] = 2 + (character.level~/4);
    if (character.level > 16) {
      character.primaryStats['Bônus de Proficiência'] = 6;
    }
    notifyListeners();
  }

  int? calculatePassivePerception() {
    int wisdom = calcutateModificator(character.stats['Sabedoria']!);
    int proeficiency = character.primaryStats['Bônus de Proficiência']!;

    if (isProeficient('Percepcao')) {
      character.primaryStats['Percepção Passiva'] = 10 + wisdom + proeficiency;
    } else {
      character.primaryStats['Percepção Passiva'] = 10 + wisdom;
    }
    return character.primaryStats['Percepção Passiva'];
  }

  void updateSkills(String value, int index) {
    if (value.trim().isNotEmpty && int.tryParse(value.trim()) != null) {
      if (character.skills[character.skills.keys.elementAt(index)] is Map<String, dynamic>) {
        (character.skills[character.skills.keys.elementAt(index)] as Map<String, dynamic>)['valor'] = int.parse(value.trim());
      }
    } 
  
    notifyListeners();
  }

  void loadAllCharactersToList() async {

    int quantity = await FilesProvider().getCharactersQuantityInPath();
    for (int index=0 ; index < quantity; index++) {
      
      String? fullPath = await FilesProvider().getNameOfFiles(index);
      
      if (fullPath != null) {
        String fileName = path.basename(fullPath);
        
        List<String> parts = fileName.split('_');

        String lastPart = parts.last;
        List<String> lastPartAndExtension = lastPart.split('.');
        parts[parts.length - 1] = lastPartAndExtension.first;
        
        bool listExists = listOfCharacters.any((character) => listEquals(character, parts));
        if (!listExists) {
          listOfCharacters.add(parts);
          notifyListeners();
        }
      }
    }
  }

  void searchCharactersByString(String search) async {

    listOfCharacters.clear();
    int quantity = await FilesProvider().getCharactersQuantityInPath();
    for (int index=0 ; index < quantity; index++) {
      
      String fullPath = await FilesProvider().getNameOfFiles(index);
      String fileName = path.basename(fullPath);
      
      List<String> parts = fileName.split('_');

      String lastPart = parts.last;
      List<String> lastPartAndExtension = lastPart.split('.');
      parts[parts.length - 1] = lastPartAndExtension.first;
      
      for (int i = 0; i < parts.length; i++) {
        if (parts[i].toLowerCase().contains(search.toLowerCase())) {
          listOfCharacters.add(parts);
          break;
        }
      }
    }
    
    notifyListeners();
  }

  void deleteCharacter() async {
    FilesProvider().deleteFolderAndRenameAll(indexesSelected);

    for (int index in indexesSelected) {
      listOfCharacters.removeAt(index);
    }
    loadAllCharactersToList();
    notifyListeners();
  }

}