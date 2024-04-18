
class Dices {
  final String diceName;
  final String diceDescription;
  final int numberOfDicesToRoll;
  final String diceIcon;

  Dices({
    required this.diceName, 
    required this.diceDescription, 
    required this.numberOfDicesToRoll,
    this.diceIcon = "assets/images/dice-d6.png",
  });
}

List<Dices> dicesList = [
  Dices(diceName: "D4", diceDescription: "Dado de 4 faces", numberOfDicesToRoll: 0, diceIcon:  "assets/images/dice-d4.png"),
  Dices(diceName: "D6", diceDescription: "Dado de 6 faces", numberOfDicesToRoll: 0, diceIcon:  "assets/images/dice-d6.png"),
  Dices(diceName: "D8", diceDescription: "Dado de 8 faces", numberOfDicesToRoll: 0, diceIcon:  "assets/images/dice-d8.png"),
  Dices(diceName: "D10", diceDescription: "Dado de 10 faces", numberOfDicesToRoll: 0, diceIcon:  "assets/images/dice-d10.png"),
  Dices(diceName: "D12", diceDescription: "Dado de 12 faces", numberOfDicesToRoll: 0, diceIcon:  "assets/images/dice-d12.png"),
  Dices(diceName: "D20", diceDescription: "Dado de 20 faces", numberOfDicesToRoll: 0, diceIcon:  "assets/images/dice-d20.png"),
  Dices(diceName: "D100", diceDescription: "Dado de 100 faces", numberOfDicesToRoll: 0, diceIcon: "assets/images/dice-d10.png"),
];