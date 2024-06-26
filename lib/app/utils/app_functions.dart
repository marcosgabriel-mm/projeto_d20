import 'package:flutter/material.dart';
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
              onPressed: () => Navigator.pop(context, item == "Excluir"),
              child: Text(
                item,
                style: TextStyles.instance.boldItalic,
              ),
            )
        ],
      ),
    );
  }

}
