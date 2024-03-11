import 'package:d20_project/app/pages/initiatives/widgets/initiatives_appbar.dart';
import 'package:d20_project/app/pages/initiatives/widgets/initiatives_itens.dart';
import 'package:d20_project/app/pages/initiatives/widgets/bottomBar/initiatives_bottom_menu.dart';
import 'package:d20_project/app/models/players.dart';
import 'package:d20_project/styles/colors_app.dart';
import 'package:d20_project/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class InitiativeView extends StatefulWidget {
  final VoidCallback onSelectionModeChanged;

  const InitiativeView({
    super.key,   
    required this.onSelectionModeChanged     
  });

  @override
  State<InitiativeView> createState() => _InitiativeViewState();
}

class _InitiativeViewState extends State<InitiativeView> {
  final ValueNotifier<int> refreshNotifier = ValueNotifier<int>(0);
  var _icon = Icons.radio_button_off;
  var isSelectionMode = false;

  @override
  void initState() {
    super.initState();
    refreshNotifier.addListener(_refreshList);
    
  }

  @override
  void dispose() {
    refreshNotifier.removeListener(_refreshList);
    super.dispose();
  }

  void _refreshList() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isSelectionMode) {
          setState(() {
            isSelectionMode = false;
            widget.onSelectionModeChanged();
            _icon = Icons.radio_button_off;
            for (var element in playersList) {
              element.isSelected = false;}
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: BarraApp(
          refreshNotifier: refreshNotifier, 
          isSelectionMode: isSelectionMode,
          icon: _icon,
          onIconChanged: (icon) {
            setState(() {
              _icon = icon;
            });
          },
        ),
        bottomNavigationBar: !isSelectionMode 
          ? const SizedBox()
          : SelectionBottomMenu(
            callback: () {
              setState(() {
                isSelectionMode = false;
                _icon = Icons.radio_button_off;
                for (var element in playersList) {
                  element.isSelected = false;
                }
              });
            },
          ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [          
              playersList.isEmpty
              ? Column(
                children: [
                  SvgPicture.asset("assets/svg/CampoDeBatalha.svg"),
                  const SizedBox(height: 36),
                  Text("Não há nada aqui", style: TextStyles.instance.regular ,)
                ],
              )
              : Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: playersList.length,
                  itemBuilder: (context, index) => ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all<double>(0),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        playersList[index].isSelected && isSelectionMode
                        ? ColorsApp.instance.secondaryColor
                        : ColorsApp.instance.primaryColor,
                      ),
                    ),
                    onLongPress: () {
                      setState(() {
                        if (isSelectionMode){ return;}
                        isSelectionMode = true;
                        widget.onSelectionModeChanged();
                        playersList[index].isSelected = !playersList[index].isSelected;
                      });
                    },
                    onPressed: () {
                      setState(() {
                            playersList[index].isSelected = !playersList[index].isSelected;
                      });
                    },
                    child: ItensNames(
                          playerName: playersList[index].playerName, 
                          playerClass: playersList[index].playerClass,
                          initiatives: int.parse(playersList[index].initiatives.toString()),
                          icon: playersList[index].isSelected ? Icons.radio_button_on : _icon,
                          isSelectionMode: isSelectionMode,
                          alignText: TextAlign.center, 
                        ),
                  ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

