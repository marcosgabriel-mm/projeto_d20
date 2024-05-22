import 'package:d20_project/styles/colors_app.dart';
import 'package:d20_project/styles/text_styles.dart';
import 'package:flutter/material.dart';

class InputSheet extends StatelessWidget {
  final String campoTexto;
  final String entradaExemplo;
  final TextEditingController controller;
  final double width;
  
  const InputSheet({
    super.key, 
    required this.campoTexto, 
    required this.entradaExemplo, 
    required this.controller, required this.width, 
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8, top: 22),
            child: Text(campoTexto, style: TextStyles.instance.regular),
          ),
          TextFormField(
            keyboardType: keyboardType(campoTexto),
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
            controller: controller,
            cursorColor: Colors.white,
            style: TextStyles.instance.boldItalic,
            decoration: InputDecoration(
              hintText: entradaExemplo,
              hintStyle: TextStyles.instance.regular.copyWith(color: Colors.white30),
              fillColor: ColorsApp.instance.secondaryColor,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
  
}

TextInputType keyboardType(String campoTexto){
  if (campoTexto.contains("Quantidade de lados") || campoTexto.contains("Iniciativa") || campoTexto.contains("CD Magia") || campoTexto.contains("CD")) {
    return TextInputType.number;
  } else {
    return TextInputType.text;
  }
}