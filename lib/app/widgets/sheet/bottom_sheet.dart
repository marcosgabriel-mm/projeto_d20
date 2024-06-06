import 'package:d20_project/app/models/initiatives.dart';
import 'package:d20_project/app/providers/initiatives_provider.dart';
import 'package:d20_project/app/widgets/damage_type.dart';
import 'package:d20_project/app/widgets/sheet/bottom_sheet_input.dart';
import 'package:d20_project/styles/colors_app.dart';
import 'package:d20_project/styles/text_styles.dart';
import 'package:d20_project/theme/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomSheetModal {

  static Future addOrEditInitiative(BuildContext context, bool isEditing, [Initiatives? initiative]) {
    List<TextEditingController> controller = List.generate(6, (index) => TextEditingController());
    
    if (initiative != null){
      controller[0].text = initiative.playerName;
      controller[1].text = initiative.playerClass;
      controller[2].text = initiative.hitPoints.toString();
      controller[3].text = initiative.initiatives.toString();
      controller[4].text = initiative.spellClass.toString();
      controller[5].text = initiative.armorClass.toString();

      context.read<InitiativesProvider>().resistanceTypesSelected = List<String>.from(initiative.resistanceTypes ?? []);
      context.read<InitiativesProvider>().weaknessTypesSelected = List<String>.from(initiative.weaknessTypes ?? []);

    }else {
      for (var element in controller) {
        element.clear();
        context.read<InitiativesProvider>().resistanceTypesSelected.clear();
        context.read<InitiativesProvider>().weaknessTypesSelected.clear();
      }
    }
    
    return  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: Colors.black.withOpacity(0.5),
      backgroundColor: ColorsApp.instance.primaryColor,
      
      // shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(15))), 
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 1.6,
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.all(horizontalPadding*2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Nova Iniciativa", style: TextStyles.instance.regular,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InputSheet(campoTexto: "Nome", entradaExemplo: "Kuth", controller: controller[0], width: 85),
                          InputSheet(campoTexto: "Classe", entradaExemplo: "Mago", controller: controller[1], width: 85),
                          InputSheet(campoTexto: "Vida", entradaExemplo: "36", controller: controller[2], width: 85)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InputSheet(campoTexto: "Iniciativa", entradaExemplo: "15", controller: controller[3], width: 85,),
                          InputSheet(campoTexto: "CD Magia", entradaExemplo: "10", controller: controller[4], width: 85),
                          InputSheet(campoTexto: "CD", entradaExemplo: "15", controller: controller[5], width: 85)
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: verticalPadding),
                        child: ExpansionTile(
                          maintainState: true,
                          title: Text("Resistências", style: TextStyles.instance.regular,),
                          collapsedIconColor: Colors.white,
                          iconColor: Colors.white,
                          childrenPadding: const EdgeInsets.symmetric(vertical: verticalPadding),
                          children: [
                            Wrap(
                              spacing: horizontalPadding,
                              runSpacing: verticalPadding,
                              children: [
                                for (var damageType in context.read<InitiativesProvider>().damageTypes)
                                DamageType(
                                  damageType: "Resistências",
                                  damageTypeText: damageType,
                                  damageTypeSvg: "assets/svg/damage_types/${damageType.toLowerCase()}.svg",
                                ),
                              ]
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: verticalPadding),
                        child: ExpansionTile(
                          maintainState: true,
                          title: Text("Fraquezas", style: TextStyles.instance.regular,),
                          collapsedIconColor: Colors.white,
                          iconColor: Colors.white,
                          childrenPadding: const EdgeInsets.symmetric(vertical: verticalPadding),
                          children: [
                            Wrap(
                              spacing: horizontalPadding,
                              runSpacing: verticalPadding,
                              children: [
                                for (var damageType in context.read<InitiativesProvider>().damageTypes)
                                DamageType(
                                  damageType: "Fraquezas",
                                  damageTypeText: damageType,
                                  damageTypeSvg: "assets/svg/damage_types/${damageType.toLowerCase()}.svg",
                                ),
                              ]
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: ElevatedButton(
                          onPressed: () {
                            if (isEditing) {
                              Navigator.pop(context, controller);
                            }else{
                              context.read<InitiativesProvider>().addInitiative(controller);
                              Navigator.pop(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorsApp.instance.secondaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            height: 65,
                            child: Center(
                              child: Text("Feito", style: TextStyles.instance.regular),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ]
            ),
          ),
        );
      }
    );
  }
}

Future displayBottomSheet(BuildContext context, String title, List<List<String>> fields, Function function) {

  final formKey = GlobalKey<FormState>();
  List<TextEditingController> controllers = List.generate(fields.length, (index) => TextEditingController());
  for (var element in controllers) {element.clear();}

  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: Colors.black.withOpacity(0.5),
      backgroundColor: ColorsApp.instance.primaryColor,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 18),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style:TextStyles.instance.regular.copyWith(fontSize: 20)),
                    for (var firstField in fields)
                      InputSheet(
                          campoTexto: firstField[0],
                          entradaExemplo: firstField[1],
                          controller: controllers[fields.indexOf(firstField)],
                          width: 150,                          
                        ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            function(controllers);
                            Navigator.pop(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsApp.instance.secondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          height: 65,
                          child: Center(
                            child: Text("Feito", style: TextStyles.instance.regular),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
