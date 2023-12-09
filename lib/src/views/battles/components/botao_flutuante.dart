import 'package:d20_project/src/views/battles/components/overlay_inferior.dart';
import 'package:d20_project/styles/colors_app.dart';
import "package:flutter/material.dart";

class BotaoFlutuante extends StatelessWidget {
  const BotaoFlutuante({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () { _displayBottomSheet(context); },
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
      child: const Icon(Icons.add)
    );
  }
}


//todo mover pra outro lugar
Future _displayBottomSheet(BuildContext context){
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    barrierColor: Colors.black.withOpacity(0.5),
    backgroundColor: ColorsApp.instance.primaryColor,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
    builder: (BuildContext context) {
      return Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding (
          padding: const EdgeInsets.all(16),
          child: Form (
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const OverlayInferior(campoTexto: "NOME", entradaExemplo: "Kuth", iconeIndicado: Icons.person),
                const OverlayInferior(campoTexto: "CLASSE", entradaExemplo: "Mago", iconeIndicado: Icons.class_),
                const OverlayInferior(campoTexto: "INICIATIVA", entradaExemplo: "18", iconeIndicado: Icons.onetwothree),
                ElevatedButton(
                  onPressed: () {},
                  child: const Icon(Icons.save)
                )
              ],
            ),
          ),
        ),
      );
    }
  );
}