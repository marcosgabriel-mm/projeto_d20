import 'package:d20_project/app/widgets/sheet/bottom_sheet_input.dart';
import 'package:d20_project/styles/colors_app.dart';
import 'package:d20_project/styles/text_styles.dart';
import 'package:flutter/material.dart';


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
                          controller: controllers[fields.indexOf(firstField)]                          
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
