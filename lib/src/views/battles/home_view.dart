import 'package:d20_project/src/views/battles/components/battle%20_item.dart';
import 'package:d20_project/src/views/battles/components/battle_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'components/app_bar.dart';
import 'components/botao_flutuante.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BarraAplicativo(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: SvgPicture.asset(
              "assets/svg/BarraSuperior.svg",
              height: 30,
              alignment: Alignment.center,
            ),
          ),
          const BattleName(),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 15,
              itemBuilder: (context, index) => Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const BattleItem(
                    valorDaIniciativa: 18,
                    nameItem: 'KUTH\nMAGO', // Alterar de acordo com uma ordem de iniciativas
                    color: Colors.white, // Fazer uma conta de acordo com a vida
                    alignText: TextAlign.center,
                  ),
                  SvgPicture.asset(
                    "assets/svg/LinhaDivisoria.svg"
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: const BotaoFlutuante(),
    );
  }
}
