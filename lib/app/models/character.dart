class Character {
  final String name;
  final String race;
  final String classType;

  int level;
  final int experience;
  final int maxHitPoints;
  final int currentHitPoints;

  final Map<String, int> stats;
  final Map<String, Object> skills;
  final Map<String, int> primaryStats;

  Character({
    required this.name,
    required this.race,
    required this.classType,
    required this.level,
    required this.experience,
    required this.maxHitPoints,
    required this.currentHitPoints,
    required this.skills,
    Map<String, int>? primaryStats,
    Map<String, int>? stats,
  })  : primaryStats = primaryStats ?? {},
        stats = stats ?? {};
}

