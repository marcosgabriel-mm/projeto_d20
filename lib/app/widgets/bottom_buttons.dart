import 'package:d20_project/styles/colors_app.dart';
import 'package:d20_project/styles/text_styles.dart';
import 'package:flutter/material.dart';

class BottomButtonMenu extends StatelessWidget {
  
  final String textLabel;
  final IconData icon;
  final Function onPressed;
  
  const BottomButtonMenu({
    super.key, 
    required this.textLabel, 
    required this.icon, 
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => onPressed(),
        style: ButtonStyle(
          elevation: const WidgetStatePropertyAll(0),
          backgroundColor: WidgetStateProperty.all<Color?>(ColorsApp.instance.primaryColor),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
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
      ),
    );
  }
}

