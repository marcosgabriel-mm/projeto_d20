import 'package:d20_project/app/pages/initiatives/widgets/Sheet/initiatives_sheet_input.dart';
import 'package:d20_project/app/models/players.dart';
import 'package:d20_project/styles/colors_app.dart';
import 'package:d20_project/styles/text_styles.dart';
import 'package:flutter/material.dart';

final nomeController = TextEditingController();
final classeController = TextEditingController();
final iniciativaController = TextEditingController();

Future displayBottomSheet(BuildContext context, Function callback){

  nomeController.clear();
  classeController.clear();
  iniciativaController.clear();

  return showModalBottomSheet( //todo - melhorar a aparência do bottom sheet
    context: context,
    isScrollControlled: true,
    barrierColor: Colors.black.withOpacity(0.5),
    backgroundColor: ColorsApp.instance.primaryColor,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
    builder: (BuildContext context) {
      return Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding (
          padding: const EdgeInsets.all(16),
          child: Form (
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 18),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Nova iniciativa", style: TextStyles.instance.regular.copyWith(fontSize: 20)),
                  InputSheet(campoTexto: "Nome", entradaExemplo: "Kuth", controller: nomeController),
                  InputSheet(campoTexto: "Classe", entradaExemplo: "Mago", controller: classeController),
                  InputSheet(campoTexto: "Iniciativa", entradaExemplo: "12", controller: iniciativaController),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: ElevatedButton(
                      onPressed: () {
                        playersList.add(
                          Players(
                            playerName: nomeController.text,
                            playerClass: classeController.text,
                            initiatives: int.parse(iniciativaController.text),
                            isSelected: false,
                        ));
                        playersList.sort((a, b) => b.initiatives.compareTo(a.initiatives));
                        callback();
                        Navigator.pop(context);
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
    }
  );
}