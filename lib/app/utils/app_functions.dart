
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:d20_project/app/providers/d20_provider.dart';
import 'package:d20_project/app/providers/initiatives_provider.dart';
import 'package:d20_project/app/providers/notes_provider.dart';
import 'package:d20_project/styles/colors_app.dart';
import 'package:d20_project/styles/text_styles.dart';

class AppFunctions {
  
  static Future<dynamic> screenPopUp(context, String title, String content, List<String> textButtons) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ColorsApp.instance.secondaryColor,
        title: Text(
          title,
          style: TextStyles.instance.regular,
        ),
        content: Text(
          content,
          style: TextStyles.instance.regular,
        ),
        actions: [
          for (var item in textButtons)
            TextButton(
              onPressed: () {
                Navigator.pop(context, item == "Excluir");
              },
              child: Text(
                item,
                style: TextStyles.instance.boldItalic,
              ),
            )
        ],
      ),
    );
  }

  //muda na appbar
  static void checkScreenToSelectEveryone(BuildContext context) {
    switch (context.read<D20Provider>().currentRoute) {
      case "Iniciativas":
        context.read<InitiativesProvider>().selectOrUnselectAll();
        break;
      case "Anotações":
        context.read<NotesProvider>().selectOrUnselectAll();
        break;
      default:
    }
  }

}
