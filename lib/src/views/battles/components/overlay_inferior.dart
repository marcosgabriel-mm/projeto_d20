import 'package:d20_project/styles/text_styles.dart';
import 'package:flutter/material.dart';

class OverlayInferior extends StatelessWidget {
  const OverlayInferior({super.key, required this.campoTexto, required this.entradaExemplo, required this.iconeIndicado});

  final String campoTexto;
  final String entradaExemplo;
  final IconData iconeIndicado;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(
          keyboardType: _inputType(campoTexto),
          style: TextStyles.instance.regular,
          decoration: InputDecoration(
            hintText: entradaExemplo,
            labelText: campoTexto,
            prefixIcon: Icon(iconeIndicado, color: Colors.white,),
            hintStyle: TextStyles.instance.regular.copyWith(color: Colors.white70),
          ),
        ),
      ),
    );
  }
}

TextInputType _inputType(String campoTexto){
 
  if (campoTexto != "INICIATIVA") 
  {
    return TextInputType.name;
  }
  else
  {
    return TextInputType.number;
  }
}