class Character {
  String name;
  String race;
  String classType;
  String description;

  int level;
  int experience;
  int maxHitPoints;
  int currentHitPoints;

  int spellClass;

  Map<String, dynamic> stats;
  Map<String, dynamic> skills;
  Map<String, int> primaryStats;
  List<Map<dynamic, dynamic>> spells;

  //TODO: colocar equipamentos

  Map<String, dynamic> toJson() {
    return {
      "name" : name,
      "race" : race,
      "classType" : classType,
      "spellClass" : spellClass,
      "level" : level,
      "experience" : experience,
      "maxHitPoints" : maxHitPoints,
      "currentHitPoints" : currentHitPoints,
      "description" : description,
      "skills" : skills,
      "primaryStats" : primaryStats,
      "stats" : stats,
      "spells" : spells,
    };
  }

  Character({
    required this.name,
    required this.race,
    required this.classType,
    required this.level,
    required this.experience,
    required this.maxHitPoints,
    required this.currentHitPoints,
    required this.skills,
    required this.description,
    required this.spells,
    required this.spellClass,
    required this.primaryStats,
    required this.stats,
  });
}

