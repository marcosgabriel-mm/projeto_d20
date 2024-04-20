import 'package:d20_project/app/utils/app_functions.dart';
import 'package:d20_project/styles/text_styles.dart';
import 'package:flutter/material.dart';

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
          AppFunctions.callFunction(textLabel, context);
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
      ),
    );
  }
}

