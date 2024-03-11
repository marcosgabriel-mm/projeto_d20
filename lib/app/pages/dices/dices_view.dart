import 'package:d20_project/styles/text_styles.dart';
import 'package:flutter/material.dart';

class Dices extends StatelessWidget {
  const Dices({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dices'),
      ),
      body: Center(
        child: Text('Dices', style: TextStyles.instance.boldItalic,),
      ),
    );
  }
}