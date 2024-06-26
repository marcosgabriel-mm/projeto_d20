import 'dart:io';

import 'package:d20_project/app/providers/characters_provider.dart';
import 'package:d20_project/app/widgets/selection_bottom_menu.dart';
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
    context.read<CharacterProvider>().loadAllCharactersToList();
  }

  @override
  Widget build(BuildContext context) {
    d20provider = context.watch<D20Provider>();
    characterProvider = context.watch<CharacterProvider>();

    // if(!d20provider.onSearch){
    //   characterProvider.loadAllCharactersToList();
    // }

    // FilesProvider().deleteFolderAndRenameAll(0);

    return PopScope(
      canPop: d20provider.isSelectionMode ? false : true,
      onPopInvoked: (bool didPop) {
        if (didPop) {
          return;
        }
        if(d20provider.isSelectionMode){
          d20provider.toogleSelectionModeAndBottomBar();
          characterProvider.indexesSelected.clear();
        }
      },
      child: Scaffold(
        appBar: ApplicationBar(
          title: 'Personagens',
          areAllSelected: d20provider.areAllSelectedFromThatScreen(context),
          onSearch: (value) => characterProvider.searchCharactersByString(value),
          onSearchClose: () => characterProvider.loadAllCharactersToList(),
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
        bottomNavigationBar: 
        !d20provider.isSelectionMode 
        ? const SizedBox.shrink() 
        : SelectionBottomMenu(
          textLabel: const ["Excluir"],
          icons: const [Icons.delete],
          onPressed: [
              () {
                characterProvider.deleteCharacter();
                d20provider.toogleSelectionModeAndBottomBar();
              }
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(microseconds: 500));
            setState(() {
              characterProvider.listOfCharacters.clear();
              characterProvider.loadAllCharactersToList();
            });
          },
          child: characterProvider.listOfCharacters.isEmpty
          ? ListView(
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
            )
          : ListView.builder(
            itemCount: characterProvider.listOfCharacters.length,
            padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: verticalPadding),
                child: GestureDetector(
                  onTap: () {
                    if (d20provider.isSelectionMode) {
                      if (characterProvider.indexesSelected.contains(index)) {
                        characterProvider.removeIndexSelected(index);
                      } else {
                        characterProvider.addIndexSelected(index);
                      }
                    }
                    // print(characterProvider.indexesSelected);
                  },
                  child: ListTile(
                    enabled: d20provider.isSelectionMode ? false : true,
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
                    leading: SizedBox(
                      width: d20provider.isSelectionMode ? 90 : 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          d20provider.isSelectionMode 
                          ? Icon(
                            characterProvider.indexesSelected.contains(index)
                            ? Icons.radio_button_on 
                            : Icons.radio_button_off,
                            color: Colors.white,
                          )
                          : const SizedBox.shrink(),
                          Stack(
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
                                    return GestureDetector(
                                      onLongPress: () => FilesProvider().saveNewPhoto(index),
                                      onTap: () {
                                        if (d20provider.isSelectionMode){
                                          return;
                                        }
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Dialog(
                                              child: PhotoView(
                                                imageProvider: FileImage(File(imageSnapshot.data ?? "assets/images/person_add.png")),
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
                                                imageSnapshot.data ?? "assets/images/person_add.png"
                                              )
                                            ), 
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                },
                              )
                            ] 
                          ),
                        ],
                      ),
                    ),
                    onLongPress: () {
                      d20provider.toogleSelectionModeAndBottomBar();
                      characterProvider.addIndexSelected(index);
                    },
                    onTap: () async {
                      String fullPath = await FilesProvider().getNameOfFiles(index);
                      if (context.mounted) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CharacterDetails(
                              fullPath: fullPath, 
                              index: index,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              );
            }
          )
        )
      ),
    );
  }
}