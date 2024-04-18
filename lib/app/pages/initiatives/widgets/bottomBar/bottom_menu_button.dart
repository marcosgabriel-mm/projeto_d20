import 'package:d20_project/app/providers/initiatives_provider.dart';
import 'package:d20_project/app/providers/players_provider.dart';
import 'package:d20_project/styles/colors_app.dart';
import 'package:d20_project/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomButtonMenu extends StatelessWidget {
  
  final String textLabel;
  final IconData icon;
  
  const BottomButtonMenu({
    super.key, 
    required this.textLabel, 
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          if (textLabel == "Excluir") {
            removePlayerList(context);
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

Future<dynamic> removePlayerList(context) {
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
            context.read<PlayersProvider>().removePlayer();
            context.read<InitiativesProvider>().setIcon(Icons.radio_button_off);
            context.read<InitiativesProvider>().toogleSelectionMode();
            Navigator.pop(context);
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