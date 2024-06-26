import 'package:d20_project/app/pages/initiatives/widgets/additional_information.dart';
import 'package:d20_project/app/pages/initiatives/widgets/initiatives_details.dart';
import 'package:d20_project/app/pages/initiatives/widgets/tile_information.dart';
import 'package:d20_project/app/widgets/add_button.dart';
import 'package:d20_project/app/widgets/appbar.dart';
import 'package:d20_project/app/widgets/selection_bottom_menu.dart';
import 'package:d20_project/app/providers/d20_provider.dart';
import 'package:d20_project/app/providers/initiatives_provider.dart';
import 'package:d20_project/app/widgets/sheet/bottom_sheet.dart';
import 'package:d20_project/app/widgets/sort_button.dart';
import 'package:d20_project/styles/colors_app.dart';
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
  late D20Provider d20Provider;

  @override
  Widget build(BuildContext context) {
    initiativesProvider = context.watch<InitiativesProvider>();
    d20Provider = context.watch<D20Provider>();
    return PopScope(
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        if (d20Provider.isSelectionMode) {
          d20Provider.toogleSelectionModeAndBottomBar();
          initiativesProvider.turnAllUnselected();
        }
      },
      child: Scaffold(
        appBar: ApplicationBar(
          title: context.read<D20Provider>().currentRoute, 
          actions : [
            AddButton(function: () => BottomSheetModal.addOrEditInitiative(context, false)),
            Padding(
              padding: const EdgeInsets.only(right: horizontalPadding),
              child: SortButton(
                listOfSorts: const ["Crescente", "Decrescente", "Nome", "Classe"],
                padding: horizontalPadding,
                function: (value) {
                  if (value != null) {
                    initiativesProvider.sortInitiatives(value);
                  }
                },
              ),
            )
          ],
          areAllSelected: initiativesProvider.areEveryoneSelected(),  
          selectEveryObject: () => initiativesProvider.selectAll(),
        ),
        bottomNavigationBar: !d20Provider.isSelectionMode 
        ? const SizedBox.shrink() 
        : SelectionBottomMenu(
          textLabel: const ["Editar", "Excluir"], 
          icons: const [Icons.edit, Icons.delete],
          onPressed: [
            () {
              int count = 0;
              for (var i = 0; i < initiativesProvider.initiativesList.length; i++) {
                if (initiativesProvider.initiativesList[i].isSelected) {
                  count++;
                }
              }
              if (count > 1) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Mais de um item selecionado!',
                      style: TextStyles.instance.regular
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
                return;
              }
              initiativesProvider.editInitiative(context);
            },
            () => initiativesProvider.removeInitiative(context)
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              initiativesProvider.initiativesList.isEmpty
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
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: initiativesProvider.initiativesList.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.all(horizontalPadding),
                              decoration: BoxDecoration(
                                color: ColorsApp.instance.primaryColor,
                                border: const Border(
                                  bottom: BorderSide(
                                    color: Colors.white,
                                    width: 1
                                  )
                                )
                              ),
                              child: GestureDetector(
                                  onLongPress: () {
                                    if (!d20Provider.isSelectionMode) {
                                      d20Provider.toogleSelectionModeAndBottomBar();
                                    }
                                    initiativesProvider.selectInitiative(index);
                                  },
                                  onTap: () {
                                    if (d20Provider.isSelectionMode) {
                                      initiativesProvider.selectInitiative(index);
                                    }
                                  },
                                  child: ExpansionTile(
                                    leading: d20Provider.isSelectionMode ? 
                                    (initiativesProvider.initiativesList[index].isSelected 
                                      ? const Padding(
                                        padding: EdgeInsets.only(top: verticalPadding/2),
                                        child: Icon(Icons.radio_button_on, color: Colors.white,),
                                      ) 
                                      : const Padding(
                                        padding: EdgeInsets.only(top: verticalPadding/2),
                                        child: Icon(Icons.radio_button_off, color: Colors.white,),
                                      )) 
                                    : null, 
                                    title: Text(
                                      initiativesProvider.initiativesList[index].playerName,
                                      style: TextStyles.instance.regular,
                                    ),
                                    subtitle: Text(
                                      initiativesProvider.initiativesList[index].playerClass,
                                      style: TextStyles.instance.boldItalic,
                                    ),
                                    initiallyExpanded: false,
                                    enabled: d20Provider.isSelectionMode ? false : true,
                                    trailing: SizedBox(
                                      width: 140,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          TileInformation(
                                            text: initiativesProvider.initiativesList[index].hitPoints.toString(), 
                                            label: "PV"
                                          ),
                                          TileInformation(
                                            text: initiativesProvider.initiativesList[index].initiatives.toString(), 
                                            label: "Iniciativa"
                                          )
                                        ],
                                      ),
                                    ),
                                    children: [
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                child: InitiativesDetails(
                                                  damagesTypes: initiativesProvider.initiativesList[index].resistanceTypes ?? [],
                                                  title: "Res",
                                                ),
                                              ),
                                              InitiativesDetails(
                                                damagesTypes: initiativesProvider.initiativesList[index].weaknessTypes ?? [],
                                                title: "Fra",
                                              ),
                                            ],
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: horizontalPadding),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  AdditionalInformation(
                                                    value: initiativesProvider.initiativesList[index].spellClass.toString(), 
                                                    asset: "assets/svg/sc.svg", 
                                                    field: "CD Magia"
                                                  ),
                                                  AdditionalInformation(
                                                    value: initiativesProvider.initiativesList[index].armorClass.toString(), 
                                                    asset: "assets/svg/cd.svg", 
                                                    field: "CD"
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      );
                    }
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}