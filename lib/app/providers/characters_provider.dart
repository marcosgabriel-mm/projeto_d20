import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;

import 'package:d20_project/app/models/character.dart';
import 'package:d20_project/app/providers/files_provider.dart';

class CharacterProvider extends ChangeNotifier {

  Character character = Character(
    name: "Nome",
    race: "Raça",
    classType: "Classe",
    level: 1,
    experience: 0,
    maxHitPoints: 0,
    currentHitPoints: 0,
    spellClass: 0,
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
      'Força': {
        'valor': 0,
        'salvaguarda': false
      },
      'Destreza': {
        'valor': 0,
        'salvaguarda': false
      },
      'Constituição': {
        'valor': 0,
        'salvaguarda': false
      },
      'Inteligência': {
        'valor': 0,
        'salvaguarda': false
      },
      'Sabedoria': {
        'valor': 0,
        'salvaguarda': false
      },
      'Carisma': {
        'valor': 0,
        'salvaguarda': false
      },
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
    },
    spells: [] 
  );
  Character characterDefault = Character(
    name: "Nome",
    race: "Raça",
    classType: "Classe",
    level: 1,
    experience: 0,
    maxHitPoints: 0,
    currentHitPoints: 0,
    spellClass: 0,
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
      'Força': {
        'valor': 0,
        'salvaguarda': false
      },
      'Destreza': {
        'valor': 0,
        'salvaguarda': false
      },
      'Constituição': {
        'valor': 0,
        'salvaguarda': false
      },
      'Inteligência': {
        'valor': 0,
        'salvaguarda': false
      },
      'Sabedoria': {
        'valor': 0,
        'salvaguarda': false
      },
      'Carisma': {
        'valor': 0,
        'salvaguarda': false
      },
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
    },
    spells: [] 
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


  List<Map<String, String>> listOfCharacters = [];

  void loadCharacter(int index) async {

    if (index.isNegative) {
      character = characterDefault;
      return;
    }

    Map<String, dynamic> json = await FilesProvider().getJson(index);

    Map<String, dynamic> primaryStatsMap = json['primaryStats'];
    Map<String, int>? primaryStats = primaryStatsMap.map((key, value) => MapEntry(key, int.tryParse(value.toString()) ?? 0));

    List<dynamic> spellsJson = json['spells'];
    List<Map<String, dynamic>> spells = spellsJson.map((spell) => Map<String, dynamic>.from(spell)).toList();

    character = Character(
      name: json['name'],
      race: json['race'],
      classType: json['classType'],
      level: json['level'],
      spellClass: json['spellClass'],
      experience: json['experience'],
      description: json['description'],
      maxHitPoints: json['maxHitPoints'],
      currentHitPoints: json['currentHitPoints'],
      skills: json['skills'],
      stats: json['stats'],
      spells: spells,
      primaryStats: primaryStats,
    );

    notifyListeners();
  }

  void loadFilesToList() async {

    listOfCharacters.clear();

    int quantity = await FilesProvider().getCharactersQuantityInPath();
    for (int index=0 ; index < quantity; index++) {

      Map<String, String> stringFiles = await FilesProvider().getCharacterFiles(index);
      debugPrint(stringFiles.toString());
      
      listOfCharacters.add(stringFiles);
    }
    notifyListeners();
  }

  void saveCharacter( Character character, int index) async {
    await FilesProvider().saveCharacter(character, index);
    loadFilesToList();
  }

  void deleteCharacter(int index) async {
    await FilesProvider().deleteCharacter(index);
    listOfCharacters.removeAt(index);
    notifyListeners();
  }

  calcutateModificator(int atributeValue) {

    if (atributeValue >= 101 || atributeValue <= 0) {
      return 0;
    }

    for (int index = 2; index < 101; index++) {
      if (atributeValue == 1) {
        return -5;
      }

      if (atributeValue == index) {
        return (index/2).floor()-5;
      }
    }
    notifyListeners();
  }

  void toggleProeficient(String skillName) {
    Map<String, dynamic>? skill = character.skills[skillName] as Map<String, dynamic>?;
    skill?['proficiente'] = !skill['proficiente'];
    notifyListeners();
  }

  void autoCompleteProeficiencyModifierFields() {
    for (String key in character.skills.keys) {
      Map<String, dynamic> skill = character.skills[key] as Map<String, dynamic>;
      String atributeModificator = skill['atributo'];

      int modificator = calcutateModificator(character.stats[atributeModificator]['valor']!);
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
    character.stats[character.stats.keys.elementAt(index)]['valor'] = parsedValue;
    calcutateModificator(parsedValue);
    notifyListeners();
  }

  void updateSkills(String value, int index) {
    if (value.trim().isNotEmpty && int.tryParse(value.trim()) != null) {
      if (character.skills[character.skills.keys.elementAt(index)] is Map<String, dynamic>) {
        (character.skills[character.skills.keys.elementAt(index)] as Map<String, dynamic>)['valor'] = int.parse(value.trim());
      }
    } 
  
    notifyListeners();
  }

  
  void searchCharactersByString(String search) async {

    int quantity = await FilesProvider().getCharactersQuantityInPath();
    listOfCharacters.clear(); 

    for (int index=0; index < quantity; index++) {
      Map<String, String> characterPath = await FilesProvider().getCharacterFiles(index);
      String characterStringFile = characterPath['json']!.split('/').last.replaceFirst('.json', '');
      
      if (characterStringFile.toLowerCase().contains(search.toLowerCase())) {
        listOfCharacters.add(characterPath);
      }
    }

    notifyListeners();
  }

  Future addSpellandSave(Map<String, dynamic> spell, int index) async {

    spell['prepared'] = false;
    loadCharacter(index);

    if (character.spells.isEmpty || !existsSpell(spell, character.spells) ) {
      character.spells.add(spell);
      return "Magia adicionada ao personagem";
    }

    return "Magia já existe no personagem";
  }

  void togglePreparedSpell(String spellName) {
    debugPrint(spellName);
    for (int i = 0; i < character.spells.length; i++) {
      if (character.spells[i]['name'] == spellName) {
        character.spells[i]['prepared'] = !character.spells[i]['prepared'];
        break;
      }
    }
    notifyListeners();
  }

  void changeSaveTrhow(String atributeName) {
    character.stats[atributeName]['salvaguarda'] = !character.stats[atributeName]['salvaguarda'];
    notifyListeners();
  }

  bool isProeficient(String skillName) {
    Map<String, dynamic>? skill = character.skills[skillName] as Map<String, dynamic>?;
    if (skill?['proficiente'] == true) {
      return true;
    }
    return false;
  }

  bool containsMap(List<Map> listOfCharacters, Map stringFiles) {
    for (var map in listOfCharacters) {
      if (map.length == stringFiles.length && map.keys.every((k) => map[k] == stringFiles[k])) {
        return true;
      }
    }
    return false;
  }

  bool existsSpell(Map<String, dynamic> spell, List<Map<dynamic, dynamic>> spells) {

    for (var characterSpell in spells) {
      if(characterSpell['name'] == spell['name']){
        return true;
      }
    }

    return false;
  }
}