import 'package:d20_project/styles/text_styles.dart';
import 'package:flutter/material.dart';

class InputSheet extends StatelessWidget {
  final String campoTexto;
  final String entradaExemplo;
  final TextEditingController controller;
  
  const InputSheet({
    super.key, 
    required this.campoTexto, 
    required this.entradaExemplo, 
    required this.controller, 
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8, top: 22),
            child: Text(campoTexto, style: TextStyles.instance.regular),
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, preencha o campo';
              }
              return null;
            },
            keyboardType: keyboardType(campoTexto),
            controller: controller,
            cursorColor: Colors.white,
            style: TextStyles.instance.boldItalic,
            decoration: InputDecoration(
              hintText: entradaExemplo,
              hintStyle: TextStyles.instance.regular.copyWith(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
}

TextInputType keyboardType(String campoTexto){
  if (campoTexto.contains("Quantidade de lados") || campoTexto.contains("Iniciativa")) {
    return TextInputType.number;
  } else {
    return TextInputType.text;
  }
}