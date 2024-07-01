import 'package:d20_project/app/pages/attacks/widgets/attacks_fields.dart';
import 'package:d20_project/app/providers/attacks_provider.dart';
import 'package:d20_project/app/providers/d20_provider.dart';
import 'package:d20_project/app/providers/dices_provider.dart';
import 'package:d20_project/app/widgets/add_button.dart';
import 'package:d20_project/app/widgets/appbar.dart';
import 'package:d20_project/app/widgets/sort_button.dart';
import 'package:d20_project/styles/text_styles.dart';
import 'package:d20_project/theme/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AttacksView extends StatefulWidget {
  const AttacksView({super.key});

  @override
  State<AttacksView> createState() => _AttacksViewState();
}

class _AttacksViewState extends State<AttacksView> {
  late AttacksProvider attacksProvider;
  late D20Provider d20Provider;


  TextPainter _calculateTextSize(String text) {
    var textPainter = TextPainter(
      text: TextSpan(text: text, style: TextStyles.instance.regular),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);

    return textPainter;
  }

  @override
  Widget build(BuildContext context) {
    d20Provider = context.watch<D20Provider>();
    attacksProvider = context.watch<AttacksProvider>();
    return Scaffold(
      appBar: ApplicationBar(
        title: d20Provider.currentRoute,
        actions: [
          AddButton(function: () {
            attacksProvider.addNewAttack("", "");
          }),
          const Padding(
            padding: EdgeInsets.only(right: horizontalPadding),
            child: SortButton(listOfSorts: ["Nome", "Dados"]),
          )
        ],
      ),
      body: attacksProvider.listOfAttacks.isEmpty
      ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/attacks.png",
              scale: 1.5,
            ),
            Padding(
              padding: const EdgeInsets.only(top: verticalPadding),
              child: Text("Nenhum ataque criado ainda!", style: TextStyles.instance.regular,),
            )
          ],
        ),
      )
      : ListView.builder(
        itemCount: attacksProvider.listOfAttacks.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: horizontalPadding),
            padding: const EdgeInsets.symmetric(vertical: verticalPadding),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white,
                  width: 1
                )
              )
            ),
            child: ListTile(
              title: Padding(
                padding: const EdgeInsets.only(bottom: verticalPadding),
                child: Row(
                  children: [
                    SizedBox(
                      width: _calculateTextSize(attacksProvider.listOfAttacks[index]["name"]!).size.width+horizontalPadding,
                      child: AttacksFields(
                        objectKey: "name",
                        text: attacksProvider.listOfAttacks[index]["name"]!, 
                        onTextChanged: (value) => attacksProvider.listOfAttacks[index]["name"] = value,
                        onSubmitted: (value) => attacksProvider.listOfAttacks[index]["name"] = value,
                        onTapOutside: (event) {
                        attacksProvider.saveAttacks();
                        FocusScope.of(context).unfocus();
                      },
                      )
                    ),
                  ],
                ),
              ),
              subtitle: Row(
                children: [
                  SizedBox(
                    width: _calculateTextSize(attacksProvider.listOfAttacks[index]["dice"]!).size.width+horizontalPadding,
                    child: AttacksFields(
                      text: attacksProvider.listOfAttacks[index]["dice"]!, 
                      onTextChanged: (value) => attacksProvider.listOfAttacks[index]["dice"] = value,
                      onSubmitted: (value) => attacksProvider.listOfAttacks[index]["dice"] = value,
                      onTapOutside: (event) {
                        attacksProvider.saveAttacks();
                        FocusScope.of(context).unfocus();
                      },
                    )
                  ),
                ],
              ),
              trailing: IconButton(
                onPressed: () {
                  String result = context.read<DicesProvider>().rollASingleDice(attacksProvider.listOfAttacks[index]["dice"]!, 0);
                  debugPrint("Resultado do ataque: $result");
                } ,
                tooltip: "Rolar ataque",
                icon: const Icon(Icons.casino_outlined, color: Colors.white,),
              ),
            ),
          );
        },
      ),
    );
  }

}