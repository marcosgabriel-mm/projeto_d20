class Players {

  final String playerName;
  final String playerClass;
  final int initiatives;
  bool isSelected;

  Players({
    required this.playerName,
    required this.playerClass,
    required this.initiatives,
    this.isSelected = false,
  });
  

}

List<Players> playersList = []..sort((a, b) => b.initiatives.compareTo(a.initiatives));