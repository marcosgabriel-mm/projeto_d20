import 'package:d20_project/app/pages/initiatives/initiatives_appbar.dart';
import 'package:d20_project/app/pages/initiatives/widgets/initiatives_itens.dart';
import 'package:d20_project/app/pages/initiatives/widgets/bottomBar/initiatives_bottom_menu.dart';
import 'package:d20_project/app/providers/initiatives_provider.dart';
import 'package:d20_project/app/providers/players_provider.dart';
import 'package:d20_project/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class InitiativeView extends StatefulWidget {
  final VoidCallback onSelectionModeChanged;

  const InitiativeView({super.key, required this.onSelectionModeChanged});

  @override
  State<InitiativeView> createState() => _InitiativeViewState();
}

class _InitiativeViewState extends State<InitiativeView> {
  late InitiativesProvider initiativesProvider;
  late PlayersProvider playersProvider;

  @override
  Widget build(BuildContext context) {
    initiativesProvider = context.watch<InitiativesProvider>();
    playersProvider = context.watch<PlayersProvider>();

    return WillPopScope(
      onWillPop: () async {
        if (initiativesProvider.isSelectionMode) {
          setState(() {
            initiativesProvider.toogleSelectionMode();
            initiativesProvider.setIcon(Icons.radio_button_off);
            playersProvider.turnAllUnselected();
          });

          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: BarraApp(
          title: "Iniciativas",
        ),
        bottomNavigationBar: !initiativesProvider.isSelectionMode
            ? const SizedBox()
            : const SelectionBottomMenu(),
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
                                  if (initiativesProvider.isSelectionMode) {
                                    return;
                                  }
                                  initiativesProvider.toogleSelectionMode();
                                  widget.onSelectionModeChanged();
                                  playersProvider.playerSelect(index);
                                });
                              },
                              onPressed: () {
                                setState(() {
                                  if (!initiativesProvider.isSelectionMode) {
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
                                    initiativesProvider.isSelectionMode,
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
