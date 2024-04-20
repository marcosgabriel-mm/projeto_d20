import 'package:d20_project/app/pages/initiatives/widgets/initiatives_itens.dart';
import 'package:d20_project/app/widgets/appbar.dart';
import 'package:d20_project/app/widgets/selection_bottom_menu.dart';
import 'package:d20_project/app/providers/d20_provider.dart';
import 'package:d20_project/app/providers/initiatives_provider.dart';
import 'package:d20_project/app/providers/players_provider.dart';
import 'package:d20_project/styles/text_styles.dart';
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
        appBar: const ApplicationBar(title: "Iniciativas", listOfSorts: ["Crescente", "Decrescente", "Nome", "Classe"]),
        bottomNavigationBar: !d20Provider.isSelectionMode ? const SizedBox() : const SelectionBottomMenu(textLabel: ["Editar", "Excluir"], icons: [Icons.edit, Icons.delete]),
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
                          "Não há nada aqui",
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
                            itemBuilder: (context, index) => ElevatedButton(
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all<double>(0),
                              ),
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
                              onPressed: () {
                                setState(() {
                                  if (!d20Provider.isSelectionMode) {
                                    return;
                                  }
                                  playersProvider.playerSelect(index);
                                });
                              },
                              child: ItensNames(
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
