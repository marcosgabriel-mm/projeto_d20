import 'package:d20_project/app/pages/dices/widgets/dices_custom_row.dart';
import 'package:d20_project/app/providers/d20_provider.dart';
import 'package:d20_project/app/providers/dices_provider.dart';
import 'package:d20_project/app/widgets/add_button.dart';
import 'package:d20_project/app/widgets/appbar.dart';
import 'package:d20_project/app/widgets/selection_bottom_menu.dart';
import 'package:d20_project/app/widgets/sheet/bottom_sheet.dart';
import 'package:d20_project/app/widgets/sort_button.dart';
import 'package:d20_project/styles/text_styles.dart';
import 'package:d20_project/theme/theme_config.dart';
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

    return PopScope(
      canPop: d20Provider.isSelectionMode || dicesProvider.isAnyDiceSelected ? false : true,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }        
        if (dicesProvider.isAnyDiceSelected) {
          dicesProvider.clearNumberOfDicesToRoll(context);
        } else if (d20Provider.isSelectionMode) {
          d20Provider.toogleSelectionModeAndBottomBar();
          dicesProvider.turnAllUnselected();
        }
      },
      child: Scaffold(
        appBar: ApplicationBar(
          title: context.read<D20Provider>().currentRoute, 
          actions: [
            AddButton(
                function: () => displayBottomSheet(
                  context, 
                  "Novo dado", 
                  [["Quantidade de lados", "Ex: 34"],["Descrição", "Ex: Dado de 34 faces"]],
                  context.read<DicesProvider>().addDice,
                )
              ),
            Padding(
              padding: const EdgeInsets.only(right: horizontalPadding),
              child: SortButton(
                listOfSorts: const ["Crescente", "Decrescente"],
                function: (value) {
                  if (value != null) {
                    dicesProvider.sortDices(value);
                  }
                },
              ),
            )
          ],
          selectEveryObject: () => dicesProvider.selectAll(),
          areAllSelected: dicesProvider.areEveryoneSelected(),  
        ),
        bottomNavigationBar: Stack(
          children: [
            Visibility(
              visible: d20Provider.isSelectionMode,
              child: SelectionBottomMenu(
                textLabel: const ["Excluir"],
                icons: const [Icons.delete],
                onPressed: [
                  () => dicesProvider.removeDices()
                ],
              ),
            ),
            Visibility(
              visible: dicesProvider.isAnyDiceSelected,
              child: SelectionBottomMenu(
                textLabel: const ["Limpar", "Rolar"],
                icons: const [Icons.clear_all, Icons.casino],
                onPressed: [
                  () => dicesProvider.clearNumberOfDicesToRoll(context),
                  () => dicesProvider.rollDices(context)
                ],
              ),
            ),
          ],
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.only(bottom: verticalPadding),
              child: Text("Dados Padrões", style: TextStyles.instance.regular),
            ), 
            //TODO: Mudar titulo de dados padrões para dados personalizados ao começar a exibir proxima lista
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: dicesProvider.dicesList.length,
                itemBuilder: (context, index) => ListTile(
                  onTap: () {
                    dicesProvider.selectDice(index);
                  },
                  onLongPress: () {
                    d20Provider.toogleSelectionModeAndBottomBar();
                    dicesProvider.selectDice(index);
                  },
                  title: CustomRow(
                    diceName: dicesProvider.dicesList[index].diceName,
                    diceCount: dicesProvider.dicesList[index].numberOfDicesToRoll,
                    diceIcon: dicesProvider.dicesList[index].diceIcon,
                    diceDescription: dicesProvider.dicesList[index].diceDescription,
                    icon: dicesProvider.dicesList[index].isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
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


