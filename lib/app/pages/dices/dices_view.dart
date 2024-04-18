import 'package:d20_project/app/models/dices.dart';
import 'package:d20_project/app/pages/dices/dices_custom_row.dart';
import 'package:flutter/material.dart';

class Dices extends StatelessWidget {
  const Dices({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dados"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: dicesList.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: CustomRow(
                    diceName: dicesList[index].diceName,
                    diceDescription: dicesList[index].diceDescription,
                    diceCount: dicesList[index].numberOfDicesToRoll,
                    diceIcon: dicesList[index].diceIcon,
                  ),
                ),
              ),
            )
          ]
        ),
      ),
    );
  }
}