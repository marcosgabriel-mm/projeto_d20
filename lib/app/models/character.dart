class Character {
  String name;
  String race;
  String classType;
  String description;

  int level;
  int experience;
  int maxHitPoints;
  int currentHitPoints;

  Map<String, int> stats;
  Map<String, int> primaryStats;
  Map<String, dynamic> skills;
  List<Map<dynamic, dynamic>> spells;

  //todo colocar magias, esquipamentos e mochila

  Map<String, dynamic> toJson() {
    return {
      "name" : name,
      "race" : race,
      "classType" : classType,
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
    Map<String, int>? primaryStats,
    Map<String, int>? stats,
  }) : primaryStats = primaryStats ?? {}, stats = stats ?? {};
}

