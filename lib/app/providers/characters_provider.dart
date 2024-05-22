import 'package:d20_project/app/models/character.dart';
import 'package:flutter/material.dart';

class CharacterProvider extends ChangeNotifier {

  Character _character = Character(
    name: 'Kuth',
    race: 'Humano',
    classType: 'Mago',
    level: 12,
    experience: 100000,
    maxHitPoints: 124,
    currentHitPoints: 100,
    primaryStats: {
      'Inspiração': 1,
      'Bônus de Proficiência': 4,
      'Classe de Armadura': 10,
      'Movimento': 9,
      'Iniciativa': 2,
      'Percepção Passiva': 10,
    },
    stats: {
      'Força': 10,
      'Destreza': 14,
      'Constituição': 16,
      'Inteligência': 20,
      'Sabedoria': 14,
      'Carisma': 14,
    },
    skills: {
      'Atletismo': {
        'valor': 0,
        'atributo': 'Força',
        'proficiente': false
      },
      'Acrobacia': {
        'valor': 2,
        'atributo': 'Destreza',
        'proficiente': false
      },
      'Furtividade': {
        'valor': 2,
        'atributo': 'Destreza',
        'proficiente': false
      },
      'Prestidigitação': {
        'valor': 2,
        'atributo': 'Destreza',
        'proficiente': false
      },
      'Arcanismo': {
        'valor': 9,
        'atributo': 'Inteligência',
        'proficiente': true
      },
      'Investigacao': {
        'valor': 6,
        'atributo': 'Inteligência',
        'proficiente': true
      },
      'Historia': {
        'valor': 6,
        'atributo': 'Inteligência',
        'proficiente': true
      },
      'Natureza': {
        'valor': 5,
        'atributo': 'Inteligência',
        'proficiente': false
      },
      'Religiao': {
        'valor': 5,
        'atributo': 'Inteligência',
        'proficiente': false
      },
      'Intuição': {
        'valor': 2,
        'atributo': 'Sabedoria',
        'proficiente': false
      },
      'Sobrevicencia': {
        'valor': 2,
        'atributo': 'Sabedoria',
        'proficiente': false
      },
      'Medicina': {
        'valor': 6,
        'atributo': 'Sabedoria',
        'proficiente': true
      },
      'Percepcao': {
        'valor': 2,
        'atributo': 'Sabedoria',
        'proficiente': false
      },
      'Lidar /c animais': {
        'valor': 2,
        'atributo': 'Sabedoria',
        'proficiente': false
      },
      'Atuação': {
        'valor': 2,
        'atributo': 'Carisma',
        'proficiente': false
      },
      'Persuasão': {
        'valor': 2,
        'atributo': 'Carisma',
        'proficiente': false
      },
      'Intimidação': {
        'valor': 2,
        'atributo': 'Carisma',
        'proficiente': false
      },
      'Enganação': {
        'valor': 2,
        'atributo': 'Carisma',
        'proficiente': false
      },
    },
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
        "Sobrevicencia": "assets/svg/skills/survival.svg",
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
    }
  ];

  Character get character => _character;

  calcutateModificator(int atributeValue) {
    for (int index = 2; index < 29; index++) {
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

  calculateLevel(){
    if (character.experience >= 300) {
      character.level = 2;
    } else if (character.experience >= 900) {
      character.level = 3;
    } else if (character.experience >= 2700) {
      character.level = 4;
    } else if (character.experience >= 6500) {
      character.level = 5;
    } else if (character.experience >= 14000) {
      character.level = 6;
    } else if (character.experience >= 23000) {
      character.level = 7;
    } else if (character.experience >= 34000) {
      character.level = 8;
    } else if (character.experience >= 48000) {
      character.level = 9;
    } else if (character.experience >= 64000) {
      character.level = 10;
    } else if (character.experience >= 85000) {
      character.level = 11;
    } else if (character.experience >= 100000) {
      character.level = 12;
    } else if (character.experience >= 120000) {
      character.level = 13;
    } else if (character.experience >= 140000) {
      character.level = 14;
    } else if (character.experience >= 165000) {
      character.level = 15;
    } else if (character.experience >= 195000) {
      character.level = 16;
    } else if (character.experience >= 225000) {
      character.level = 17;
    } else if (character.experience >= 265000) {
      character.level = 18;
    } else if (character.experience >= 305000) {
      character.level = 19;
    } else if (character.experience >= 355000) {
      character.level = 20;
    } else {
      character.level = 1;
    }
    notifyListeners();
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

}