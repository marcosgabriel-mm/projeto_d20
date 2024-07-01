import 'package:d20_project/styles/colors_app.dart';
import 'package:d20_project/styles/text_styles.dart';
import 'package:flutter/material.dart';

class AttacksFields extends StatelessWidget {
  final String text;
  final ValueChanged<String>? onTextChanged;
  final ValueChanged<String>? onSubmitted;
  final Function(PointerDownEvent)? onTapOutside;
  final String? objectKey;

  const AttacksFields({
    super.key, 
    required this.text, 
    this.onTextChanged, 
    this.onSubmitted, 
    this.objectKey, 
    this.onTapOutside
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    controller.text = text;

    return  TextField(
      cursorColor: Colors.white,
      textAlign: TextAlign.center,
      controller: controller,
      style: TextStyles.instance.regular,
      decoration: InputDecoration(
        border: InputBorder.none,
        disabledBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        contentPadding: EdgeInsets.zero,
        hintText: objectKey == "name" ? "Exemplo: Ataque com espada" : "Exemplo: 1d20+5",
        fillColor: objectKey == "name" ? ColorsApp.instance.primaryColor : ColorsApp.instance.secondaryColor,
        hintStyle: TextStyles.instance.regular.copyWith(color: Colors.white30),
      ),
      onChanged: (value) => onTextChanged!(value),
      onSubmitted: (value) => onSubmitted!(value),
      onTapOutside: (event) => onTapOutside!(event),
    );
  }
}