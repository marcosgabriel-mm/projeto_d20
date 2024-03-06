import 'package:d20_project/src/views/components/iniciatives_and_names.dart';
import 'package:d20_project/styles/colors_app.dart';
import 'package:d20_project/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'components/app_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
  });

  final itemCount = 7;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BarraApp(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [          
            itemCount < 1
            ? Column(
              children: [
                SvgPicture.asset("assets/svg/CampoDeBatalha.svg"),
                const SizedBox(height: 36),
                Text("NÃO HÁ NADA AQUI", style: TextStyles.instance.regular ,)
              ],
            )
            : Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: itemCount,
                itemBuilder: (context, index) => Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ItensNames(nameItem: "KUTH\nMAGO", color: ColorsApp.instance.secondaryColor, alignText: TextAlign.center, valorDaIniciativa: 20)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
