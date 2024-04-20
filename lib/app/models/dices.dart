
class Dices {
  final String diceName;
  final String diceDescription;
  final String diceIcon;
  int numberOfDicesToRoll;

  Dices({
    required this.diceName, 
    required this.diceDescription, 
    this.numberOfDicesToRoll = 0,
    this.diceIcon = "assets/images/dice-d6.png",
  });
}