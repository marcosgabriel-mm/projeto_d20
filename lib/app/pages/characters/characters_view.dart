import 'dart:io';

import 'package:d20_project/app/providers/characters_provider.dart';
import 'package:d20_project/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:photo_view/photo_view.dart';
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
    context.read<CharacterProvider>().loadFilesToList();
  }

  List<String> _separeteString(String fullPath) {

    String fileName = fullPath.split('/').last;
    String fileNameWithoutExtension = fileName.split('.').first;

    List<String> parts = fileNameWithoutExtension.split('_');

    return parts;
  }

  @override
  Widget build(BuildContext context) {
    d20provider = context.watch<D20Provider>();
    characterProvider = context.watch<CharacterProvider>();

    // FilesProvider().seeAllFolders();
  
    return Scaffold(
      appBar: ApplicationBar(
        title: 'Personagens',
        areAllSelected: d20provider.areAllSelectedFromThatScreen(context),
        onSearch: (value) => characterProvider.searchCharactersByString(value),
        onSearchClose: () => characterProvider.loadFilesToList(),
        actions: [
          IconButton(
            onPressed: () => d20provider.toggleSearch(),
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            )
          ),
          Padding(
            padding: const EdgeInsets.only(right: horizontalPadding),
            child: AddButton(
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
          ),
        ],
      ),
      body: characterProvider.listOfCharacters.isEmpty
      ? RefreshIndicator(
        onRefresh: () async {
          characterProvider.loadFilesToList();
        },
        child: ListView(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.3,),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/svg/character.svg"),
                    Padding(
                      padding: const EdgeInsets.only(top: verticalPadding),
                      child: Text(
                        'Nenhum personagem criado!',
                        style: TextStyles.instance.regular,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
      )
      : RefreshIndicator(
        onRefresh: () async {
          characterProvider.loadFilesToList();
        },
        child: ListView.builder(
          itemCount: characterProvider.listOfCharacters.length,
          padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: verticalPadding),
              child: ListTile(
                enabled: d20provider.isSelectionMode ? false : true,
                title: Text(
                  _separeteString(characterProvider.listOfCharacters[index]['json'].toString())[0],
                  style: TextStyles.instance.regular,
                ),
                subtitle: Text(
                  _separeteString(characterProvider.listOfCharacters[index]['json'].toString())[1],
                  style: TextStyles.instance.regular,
                ),
                trailing: SizedBox(
                  width: 110,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('PV',style: TextStyles.instance.regular),
                            Text(
                              _separeteString(characterProvider.listOfCharacters[index]['json'].toString())[2], 
                              style: TextStyles.instance.boldItalic,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Nível',style: TextStyles.instance.regular,),
                          Text(_separeteString(
                            characterProvider.listOfCharacters[index]['json'].toString())[3], 
                            style: TextStyles.instance.boldItalic,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                leading: SizedBox(
                  width: d20provider.isSelectionMode ? 90 : 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onLongPress: () => FilesProvider().saveNewPhoto(index),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: PhotoView(
                                  imageProvider: FileImage(
                                    File(
                                      characterProvider.listOfCharacters[index]['photo']?.toString() ?? "assets/images/addcharacter.png"
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: FileImage(
                                File(
                                  characterProvider.listOfCharacters[index]['photo']?.toString() ?? "assets/images/dice-d4.png"
                                )
                              ), 
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CharacterDetails(
                      fullPath: characterProvider.listOfCharacters[index]['json'].toString(), 
                      index: index
                    )),
                  );
                },
              ),
            );
          }
        ),
      )
    );
  }
}