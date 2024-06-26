import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final Function? function;

  const AddButton({super.key, this.function});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: "Adicionar",
      icon: const Icon(Icons.add),
      onPressed: () async => function!(),
    );
  }
}