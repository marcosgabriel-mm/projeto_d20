import 'package:d20_project/app/pages/characters/characters_details.dart';
import 'package:d20_project/app/providers/d20_provider.dart';
import 'package:d20_project/app/widgets/add_button.dart';
import 'package:d20_project/app/widgets/appbar.dart';
import 'package:d20_project/styles/text_styles.dart';
import 'package:d20_project/theme/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CharacterSheet extends StatelessWidget {
  const CharacterSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ApplicationBar(
        title: 'Personagens',
        areAllSelected: context.read<D20Provider>().areAllSelectedFromThatScreen(context),
        actions: [
          IconButton(
            onPressed: (){
              //todo abrir barra pesquisa
            },
            icon: const Icon(Icons.search)
          ),
          AddButton(
            function: (){
              //todo adicionar um novo personagem abrindo a mesma tela de CharacterDetails
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: horizontalPadding),
            child: IconButton(
              onPressed: (){
                //todo abrir tela de filtros
              },
              icon: const Icon(Icons.tune)
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(horizontalPadding),
            padding: const EdgeInsets.symmetric(vertical: verticalPadding),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white, 
                  width: 1
                )
              ),
            ),
            child: ListTile(
              title: Text('Kuth', style: TextStyles.instance.regular,),
              subtitle: Text('Mago', style: TextStyles.instance.boldItalic,),
              leading: GestureDetector(
                onLongPress: () {
                  //todo trocar foto do personagem
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(15)
                  ),
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('PV',style: TextStyles.instance.regular),
                        Text('124',style: TextStyles.instance.boldItalic,),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Nível',style: TextStyles.instance.regular,),
                        Text('12',style: TextStyles.instance.boldItalic,),
                      ],
                    ),
                  )
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CharacterDetails(),
                  ),
                );
              },
            ),
          );
        },
      )
    );
  }
}