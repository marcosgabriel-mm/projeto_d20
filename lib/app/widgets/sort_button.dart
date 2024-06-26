import 'package:flutter/material.dart';

import 'package:d20_project/styles/colors_app.dart';
import 'package:d20_project/styles/text_styles.dart';

class SortButton extends StatelessWidget {
  final List<String> listOfSorts;
  final double padding;
  final void Function(String?)? function;
  
  const SortButton({
    super.key,
    required this.listOfSorts,
    this.function, 
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.sort, color: Colors.white),
      tooltip: "Ordenar",
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: ColorsApp.instance.secondaryColor,
      onSelected: (value) { 
          if (function != null) {
            function!(value);
          }
       },
      itemBuilder: (BuildContext context) {
        return listOfSorts.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice, style: TextStyles.instance.regular),
          );
        }).toList();
      },
    );
  }
}
