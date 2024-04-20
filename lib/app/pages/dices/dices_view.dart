import 'package:d20_project/app/pages/dices/widgets/dices_custom_row.dart';
import 'package:d20_project/app/providers/d20_provider.dart';
import 'package:d20_project/app/providers/dices_provider.dart';
import 'package:d20_project/app/widgets/appbar.dart';
import 'package:d20_project/app/widgets/selection_bottom_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dices extends StatefulWidget {
  const Dices({super.key});

  @override
  State<Dices> createState() => _DicesState();
}

class _DicesState extends State<Dices> {
  late DicesProvider dicesProvider;
  late D20Provider d20Provider;

  @override
  Widget build(BuildContext context) {
    dicesProvider = context.watch<DicesProvider>();
    d20Provider = context.watch<D20Provider>();

  return WillPopScope(
    onWillPop: () async {
      if (dicesProvider.isAnyDiceSelected) {
        d20Provider.turnOffOrOnBottomBar();
        dicesProvider.clearNumberOfDicesToRoll();
        return false;
      }
        return true;
      },
      child: Scaffold(
        appBar: const ApplicationBar(title: "Dados", listOfSorts: ["Crescente", "Decrescente"],),
        bottomNavigationBar: !dicesProvider.isAnyDiceSelected ? const SizedBox() : const SelectionBottomMenu(textLabel: ["Limpar", "Rolar"], icons: [Icons.clear_all, Icons.casino]),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: dicesProvider.dicesList.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: CustomRow(
                    diceName: dicesProvider.dicesList[index].diceName,
                    diceCount: dicesProvider.dicesList[index].numberOfDicesToRoll,
                    diceIcon: dicesProvider.dicesList[index].diceIcon,
                    diceDescription: dicesProvider.dicesList[index].diceDescription,
                    diceIndex: index,
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
