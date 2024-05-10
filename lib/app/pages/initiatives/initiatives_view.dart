import 'package:d20_project/app/pages/initiatives/widgets/initiatives_itens.dart';
import 'package:d20_project/app/utils/add_functions.dart';
import 'package:d20_project/app/utils/sort_functions.dart';
import 'package:d20_project/app/widgets/add_button.dart';
import 'package:d20_project/app/widgets/appbar.dart';
import 'package:d20_project/app/widgets/selection_bottom_menu.dart';
import 'package:d20_project/app/providers/d20_provider.dart';
import 'package:d20_project/app/providers/initiatives_provider.dart';
import 'package:d20_project/app/providers/players_provider.dart';
import 'package:d20_project/app/widgets/sort_button.dart';
import 'package:d20_project/styles/text_styles.dart';
import 'package:d20_project/theme/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class InitiativeView extends StatefulWidget {
  const InitiativeView({super.key});

  @override
  State<InitiativeView> createState() => _InitiativeViewState();
}

class _InitiativeViewState extends State<InitiativeView> {
  late InitiativesProvider initiativesProvider;
  late PlayersProvider playersProvider;
  late D20Provider d20Provider;

  @override
  Widget build(BuildContext context) {
    initiativesProvider = context.watch<InitiativesProvider>();
    playersProvider = context.watch<PlayersProvider>();
    d20Provider = context.watch<D20Provider>();

    return WillPopScope(
      onWillPop: () async {
        if (d20Provider.isSelectionMode) {
          d20Provider.toogleSelectionMode();
          d20Provider.turnOffOrOnBottomBar();
          playersProvider.turnAllUnselected();
          initiativesProvider.setIcon(Icons.radio_button_off);
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: ApplicationBar(
          title: context.read<D20Provider>().currentRoute, 
          actions : [
            AddButton(
                function: AddFunctions.addSomethingAccordingToScreen(context),
              ),
            Padding(
              padding: const EdgeInsets.only(right: horizontalPadding),
              child: SortButton(
                listOfSorts: const ["Crescente", "Decrescente", "Nome", "Classe"],
                padding: horizontalPadding,
                function: (value) {
                  if (value != null) {
                    SortFunctions.verifyScreenToSort(value,context);
                  }
                },
              ),
            )
          ],
          areAllSelected: d20Provider.areAllSelectedFromThatScreen(context),  
        ),
        bottomNavigationBar: !d20Provider.isSelectionMode ? const SizedBox.shrink() : const SelectionBottomMenu(textLabel: ["Editar", "Excluir"], icons: [Icons.edit, Icons.delete]),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              playersProvider.playersList.isEmpty
                  ? Column(
                      children: [
                        SvgPicture.asset("assets/svg/CampoDeBatalha.svg"),
                        const SizedBox(height: 36),
                        Text(
                          "Nenhuma iniciativa ainda!",
                          style: TextStyles.instance.regular,
                        )
                      ],
                    )
                  : Expanded(
                      child: Consumer(
                        builder: (context, value, child) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: playersProvider.playersList.length,
                            itemBuilder: (context, index) => ListTile(
                              onLongPress: () {
                                setState(() {
                                  if (d20Provider.isSelectionMode) {
                                    return;
                                  }
                                  d20Provider.toogleSelectionMode();
                                  d20Provider.turnOffOrOnBottomBar();
                                  playersProvider.playerSelect(index);
                                });
                              },
                              onTap: () {
                                setState(() {
                                  if (!d20Provider.isSelectionMode) {
                                    return;
                                  }
                                  playersProvider.playerSelect(index);
                                });
                              },
                              title: ItensNames(
                                playerName: playersProvider
                                    .playersList[index].playerName,
                                playerClass: playersProvider
                                    .playersList[index].playerClass,
                                initiatives: int.parse(playersProvider
                                    .playersList[index].initiatives
                                    .toString()),
                                icon: playersProvider
                                        .playersList[index].isSelected
                                    ? Icons.radio_button_on
                                    : initiativesProvider.icon,
                                isSelectionMode:
                                    d20Provider.isSelectionMode,
                                alignText: TextAlign.center,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
