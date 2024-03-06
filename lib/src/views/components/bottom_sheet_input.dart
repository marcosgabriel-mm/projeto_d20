import 'package:d20_project/styles/text_styles.dart';
import 'package:flutter/material.dart';

class InputSheet extends StatelessWidget {
  const InputSheet({super.key, required this.campoTexto, required this.entradaExemplo});

  final String campoTexto;
  final String entradaExemplo;

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