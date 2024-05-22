class AddFunctions {

  // static Function addSomethingAccordingToScreen(BuildContext context){
  //   return () {
  //     if (context.read<D20Provider>().currentRoute == "Iniciativas") {
  //       displayBottomSheet(
  //         context, 
  //         "Nova iniciativa", 
  //         [["Nome", "Ex: Geraldo"],["Classe", "Ex: Guerreiro"],["Iniciativa", "Ex: 15"]],
  //         context.read<PlayersProvider>().addPlayer,
  //       );
  //     } else if (context.read<D20Provider>().currentRoute == "Dados") {
  //       displayBottomSheet(
  //         context, 
  //         "Novo dado", 
  //         [["Quantidade de lados", "Ex: 34"],["Descrição", "Ex: Dado de 34 faces"]],
  //         context.read<DicesProvider>().addDice,
  //       );
  //     } else if (context.read<D20Provider>().currentRoute == "Anotações") {
  //       Navigator.push(
  //         context, 
  //         MaterialPageRoute(
  //           builder: (context) => NotesText(
  //             noteTitle: "",
  //             noteDescription: "",
  //             index: -1,
  //           ),
  //         ),
  //       );
  //     }
  //   };

  // // }
  // => ListTile(
  //                     onLongPress: () {
  //                         if (d20Provider.isSelectionMode) {
  //                           return;
  //                         }
  //                         d20Provider.toogleSelectionModeAndBottomBar();
  //                         initiativesProvider.selectInitiative(index);
                        
  //                     },
  //                     onTap: () {
  //                         if (!d20Provider.isSelectionMode) {
  //                           return;
  //                         }
  //                         initiativesProvider.selectInitiative(index);
  //                     },
  //                     title: ItensNames( //TODO - REFATORAR
  //                       playerName: playersProvider.playersList[index].playerName,
  //                       playerClass: playersProvider.playersList[index].playerClass,
  //                       initiatives: int.parse(playersProvider.playersList[index].initiatives.toString()),
  //                       icon: playersProvider.playersList[index].isSelected ? Icons.radio_button_on : initiativesProvider.icon,
  //                       isSelectionMode: d20Provider.isSelectionMode,
  //                       alignText: TextAlign.center,
  //                     ),
  //                   ),



}