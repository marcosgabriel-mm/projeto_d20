import 'package:d20_project/app/models/players.dart';
import 'package:d20_project/styles/colors_app.dart';
import 'package:d20_project/styles/text_styles.dart';
import 'package:flutter/material.dart';

class BottomButtonMenu extends StatelessWidget {
  
  final String textLabel;
  final IconData icon;
  final Function onPressedCallback;
  
  const BottomButtonMenu({
    super.key, 
    required this.textLabel, 
    required this.icon, required this.onPressedCallback, 
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          if (textLabel == "Excluir") {
            removePlayerList(context, playersList, () => onPressedCallback());
          }
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            Text(textLabel, style: TextStyles.instance.regular),
          ],
        )
      )
    );
  }
}

Future<dynamic> removePlayerList(context, List listOfPlayers, Function callback) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: ColorsApp.instance.secondaryColor,
      title: Text(
        "Excluir Jogadores",
        style: TextStyles.instance.regular,
      ),
      content: Text(
        "Deseja realmente excluir os jogadores selecionados?",
        style: TextStyles.instance.regular,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Cancelar" , 
            style: TextStyles.instance.boldItalic,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            listOfPlayers.removeWhere((element) => element.isSelected);
            callback();
          },
          child: Text(
            "Excluir",
            style: TextStyles.instance.boldItalic,
          ),
        ),
      ],
    ),
  );
}