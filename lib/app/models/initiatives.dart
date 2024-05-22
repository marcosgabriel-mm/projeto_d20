class Initiatives {

  final String playerName;
  final String playerClass;
  final int initiatives;
  
  int? armorClass;
  int? hitPoints;
  int? spellClass; 

  bool isSelected;
  bool isExpanded;

  List<String>? resistanceTypes;
  List<String>? weaknessTypes;

  Initiatives({
    required this.playerName,
    required this.playerClass,
    required this.initiatives,
    this.armorClass,
    this.hitPoints,
    this.spellClass,
    this.resistanceTypes,
    this.weaknessTypes,
    this.isSelected = false,
    this.isExpanded = false,
  });
  

}