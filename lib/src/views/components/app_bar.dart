import 'package:d20_project/src/views/components/bottom_sheet_input.dart';
import 'package:d20_project/styles/colors_app.dart';
import 'package:d20_project/styles/text_styles.dart';
import 'package:flutter/material.dart';

class BarraApp extends StatelessWidget implements PreferredSizeWidget {
  const BarraApp({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: AppBar(
        title: Text("INICIATIVA", style: TextStyles.instance.regular),
        centerTitle: false,
        actions: [
          IconButton(

            icon: const Icon(Icons.add),
            onPressed: () { _displayBottomSheet(context); },
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.sort)
          ),
        ],
      ),
    );
  }
}

Future _displayBottomSheet(BuildContext context){
  return showModalBottomSheet(
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
                  Text("NOVA INICIATIVA", style: TextStyles.instance.regular.copyWith(fontSize: 20)),
                  const InputSheet(campoTexto: "NOME", entradaExemplo: "Kuth"),
                  const InputSheet(campoTexto: "CLASSE", entradaExemplo: "Mago"),
                  const InputSheet(campoTexto: "INICIATIVA", entradaExemplo: "12"),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: ElevatedButton(
                      onPressed: () {}, 
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
                          child: Text("FEITO", style: TextStyles.instance.regular),
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