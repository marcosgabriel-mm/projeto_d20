import 'package:d20_project/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DevelopmentPage extends StatelessWidget {
  const DevelopmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(32),
              child: Text(
                'Tela Indisponivel. Em desenvolvimento.', 
                style: TextStyles.instance.boldItalic,
              ),
            ),
            SvgPicture.asset('assets/svg/sadface.svg')
          ],
        ),
      ),
    );
  }
}