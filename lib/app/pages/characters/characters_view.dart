import 'dart:io';

import 'package:d20_project/app/providers/characters_provider.dart';
import 'package:d20_project/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:d20_project/app/pages/characters/characters_details.dart';
import 'package:d20_project/app/providers/d20_provider.dart';
import 'package:d20_project/app/providers/files_provider.dart';
import 'package:d20_project/app/widgets/add_button.dart';
import 'package:d20_project/app/widgets/appbar.dart';
import 'package:d20_project/theme/theme_config.dart';

class CharacterSheet extends StatefulWidget {
  const CharacterSheet({super.key});

  @override
  State<CharacterSheet> createState() => _CharacterSheetState();
}

class _CharacterSheetState extends State<CharacterSheet> {
  late D20Provider d20provider;
  late CharacterProvider characterProvider;

  @override
  void initState() {
    super.initState();
    context.read<CharacterProvider>().loadAllCharactersToList();
  }

  @override
  Widget build(BuildContext context) {
    d20provider = context.watch<D20Provider>();
    characterProvider = context.watch<CharacterProvider>();

    if(!d20provider.onSearch){
      characterProvider.loadAllCharactersToList();
    }

    return Scaffold(
      appBar: ApplicationBar(
        title: 'Personagens',
        areAllSelected: d20provider.areAllSelectedFromThatScreen(context),
        onSearch: (value) {
          characterProvider.searchCharactersByString(value);
        },
        actions: [
          IconButton(
            onPressed: (){
              d20provider.toggleSearch();
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            )
          ),
          AddButton(
            function: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CharacterDetails(
                    fullPath: "",
                    index: -1,
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: horizontalPadding),
            child: IconButton(
              onPressed: (){
                //todo abrir tela de filtros
              },
              icon: const Icon(
                Icons.tune,
                color: Colors.white30,
              )
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(microseconds: 500));
          setState(() {});
        },
        child: ListView.builder(
          itemCount: characterProvider.listOfCharacters.length,
          padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: verticalPadding),
              child: ListTile(
                title: Text(
                  characterProvider.listOfCharacters[index][0],
                  style: TextStyles.instance.regular,
                ),
                subtitle: Text(
                  characterProvider.listOfCharacters[index][1],
                  style: TextStyles.instance.regular,
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
                          Text(characterProvider.listOfCharacters[index][2], style: TextStyles.instance.boldItalic,),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Nível',style: TextStyles.instance.regular,),
                        Text(characterProvider.listOfCharacters[index][3], style: TextStyles.instance.boldItalic,),
                      ],
                    )
                  ],
                ),
                leading: GestureDetector(
                  onLongPress: () {
                    FilesProvider().saveNewPhoto(index);
                  },
                  onTap: () {
                    //todo abrir foto em tela cheia
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Icon(
                        Icons.person_add,
                        size: 25,
                        color: Colors.white30,
                      ),
                      FutureBuilder<String>(
                        future: FilesProvider().loadPhoto(index),
                        builder: (BuildContext context, AsyncSnapshot<String> imageSnapshot) {
                          if (imageSnapshot.connectionState == ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (imageSnapshot.hasError) {
                            return Text('Erro: ${imageSnapshot.error}');
                          } else {
                            return Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: FileImage(
                                    File(
                                      imageSnapshot.data ?? ""
                                    )
                                  ), 
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }
                        },
                      )
                    ] 
                  ),
                ),
                onTap: () {
                  late String fullPath;
                  FilesProvider().getNameOfFiles(index).then((path) {
                    fullPath = path;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CharacterDetails(
                        fullPath: fullPath, 
                        index: index
                      )
                    )
                  );
                },
              ),
            );
          }
        )
      )
    );
  }
}