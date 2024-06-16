import 'dart:async';
import 'dart:io';
import 'package:d20_project/app/models/character.dart';
import 'package:d20_project/app/providers/characters_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'dart:convert';

class FilesProvider {

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<Directory> get _localAppDirectory async {
    final path = await _localPath;
    if (!await Directory('$path/RPGHub').exists()) {
      await Directory('$path/RPGHub').create();
    }
    return Directory('$path/RPGHub');
  }

  Future<File> noteFile(String noteTitle) async {
    final appDirectory = await _localAppDirectory;
    Directory directory = Directory('${appDirectory.path}/notes');

    if (!await directory.exists()) {
      await directory.create();
    }

    return File('${directory.path}/$noteTitle.txt');
  }

  Future<File> writeNotes(String noteTitle, DateTime creationDate, DateTime modificationDate, String description) async {
    final file = await noteFile(noteTitle);
    return file.writeAsString('$noteTitle, $creationDate, $modificationDate,\n$description');
  }

  Future<void> deleteNotes(String noteTitle) async {
    final file = await noteFile(noteTitle);
    await file.delete();
  }

  Future<List<String>> readNotes(int start) async {
    final appDirectory = await _localAppDirectory;
    Directory directory = Directory('${appDirectory.path}/notes');
    
    List<String> allNotes = [];

    if (await directory.exists()) {
      List<FileSystemEntity> entities = directory.listSync();
      int end = (start + 5 > entities.length) ? entities.length : start + 5;

      for (int i = start; i < end; i++) {
        if (entities[i] is File && entities[i].path.endsWith('.txt')) {
          String contents = await File(entities[i].path).readAsString();
          List<String> notes = contents.split(',\n');
          allNotes.addAll(notes);
        }
      }
    }

    return allNotes;
  }

  Future<List<String>> searchNotesByName(String noteTitle) async {
  final appDirectory = await _localAppDirectory;
  Directory directory = Directory('${appDirectory.path}/notes');
  List<String> matchingNotes = [];

  if (await directory.exists()) {
    var entities = directory.listSync(recursive: true, followLinks: false);

    for (var entity in entities) {
      if (entity is File && entity.path.endsWith('.txt')) {

        String contents = await File(entity.path).readAsString();
        List<String> notes = contents.split(',\n');

        for (var note in notes) {
          List<String> noteParts = note.split(', ');
          String noteTittle = noteParts[0];

            if (noteTittle.toLowerCase().contains(noteTitle.toLowerCase())) {
              matchingNotes.addAll(notes);
            }
          break;
        }
      }
    }
  }

  return matchingNotes;
}
  
  Future<void> saveNewPhoto(int characterId) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final appDirectory = await _localAppDirectory;

      
      String id = (characterId+1).toString();
      Directory characterDirectory = Directory('${appDirectory.path}/characters/CHAR$id');
      if (!await characterDirectory.parent.exists()) {
        await characterDirectory.parent.create();
      }

      if (!await characterDirectory.exists()) {
        await characterDirectory.create();
      }

      String characterName = 'Character';
      String characterClass = 'Class';
      int characterLife = 0;
      int characterLevel = 0;

      if (await characterDirectory.exists()) {
        var files = characterDirectory.listSync();

        for (var file in files) {
          if (file is File) {
            if (path.extension(file.path) == '.json')  {
              List<String> parts = path.basename(file.path).split('_');
              String lastPart = parts.last;
              List<String> lastPartAndExtension = lastPart.split('.');
              parts[parts.length - 1] = lastPartAndExtension.first;
              characterName = parts[0];
              characterClass = parts[1];
              characterLife = int.parse(parts[2]);
              characterLevel = int.parse(parts[3]);
            }
          }
        }
      }

      if (await characterDirectory.exists()) {
      var files = characterDirectory.listSync();

      for (var file in files) {
        if (file is File) {
          if (path.extension(file.path) == '.jpg' || path.extension(file.path) == '.png') {
            await file.delete();
          }
        }
      }
    }

      File imageFile = File(pickedFile.path);
      await imageFile.copy('${characterDirectory.path}/${characterName}_${characterClass}_${characterLife}_$characterLevel.jpg');
    }
  }

  Future<void> saveExistentJson(int characterId, Character character) async {

    final appDirectory = await _localAppDirectory;
    String id = (characterId+1).toString();
    Directory characterDirectory = Directory('${appDirectory.path}/characters/CHAR$id');

    if (!await characterDirectory.parent.exists()) {
      await characterDirectory.parent.create();
    }

    if (!await characterDirectory.exists()) {
      await characterDirectory.create();
    }

    if (await characterDirectory.exists()) {
      List<FileSystemEntity> files = characterDirectory.listSync();
      for (var file in files) {
      if (file is File && file.path.endsWith('.json')) {
        await file.delete();
      }
      }
    }

    File jsonFile = File('${characterDirectory.path}/${character.name}_${character.classType}_${character.currentHitPoints}_${character.level}.json');
    await jsonFile.writeAsString(jsonEncode(character.toJson()));
  }

  Future<void> saveNewJson(Character character) async {
    final appDirectory = await _localAppDirectory;
    int quantity = await getCharactersQuantityInPath();

    Directory characterDirectory = Directory('${appDirectory.path}/characters/CHAR${quantity + 1}');

    if (!await characterDirectory.parent.exists()) {
      await characterDirectory.parent.create();
    }

    if (!await characterDirectory.exists()) {
      await characterDirectory.create();
    }

    File jsonFile = File('${characterDirectory.path}/${character.name}_${character.classType}_${character.currentHitPoints}_${character.level}.json');
    await jsonFile.writeAsString(jsonEncode(character.toJson()));
  }

  Future deleteFolderAndRenameAll(List<int> indexes) async {
    final appDirectory = await _localAppDirectory;
    
    for (int index in indexes){
      Directory characterDirectory = Directory('${appDirectory.path}/characters/CHAR${index+1}');

      if (await characterDirectory.exists()) {
        await characterDirectory.delete(recursive: true);
      }
    } 

    int quantity = await getCharactersQuantityInPath();
    if (quantity == 0) {
      return;
    }else{
      Directory characterDirectory = Directory('${appDirectory.path}/characters');
      int newIndex = 1;
      for (var entity in characterDirectory.listSync()) {
        if (entity is Directory) {
          String newPath = '${appDirectory.path}/characters/CHAR$newIndex';
          entity.renameSync(newPath);
          newIndex++;
        }
      }      
    }

  }

  Future loadSimpleJsonFromDirectory(String directory, CharacterProvider characterProvider) async {
    
    File jsonFile = File(directory);
    String jsonString = await jsonFile.readAsString();

    Map<String, dynamic> json = jsonDecode(jsonString);
    characterProvider.loadCharacter(json);
  }

  Future getNameOfFiles(int characterId) async {
    
    String id = (characterId+1).toString();
    final appDirectory = await _localAppDirectory;
    Directory characterDirectory = Directory('${appDirectory.path}/characters/CHAR$id');

    if(await characterDirectory.exists()){
      for (var entity in characterDirectory.listSync()) {
        if (entity is File && entity.path.endsWith('.json')) {
          return entity.path;
        }
      }
    }
    return null;
  }

  Future<String> loadPhoto(int characterId) async {
    
    final appDirectory = await _localAppDirectory;
    String id = (characterId+1).toString();
    Directory characterDirectory = Directory('${appDirectory.path}/characters/CHAR$id');
    
    if (await characterDirectory.exists()) {
      List<FileSystemEntity> entities = characterDirectory.listSync();
      for (FileSystemEntity entity in entities) {
        if (entity is File && entity.path.endsWith('.jpg')) {
          return entity.path;
        }
      }
    }
    return "";
  }

  Future getCharactersQuantityInPath() async {
  
    final appDirectory = await _localAppDirectory;
    Directory characterDirectory = Directory('${appDirectory.path}/characters');
    int quantity = 0;

    for (var entity in characterDirectory.listSync()) {
      if (entity is Directory) {
        quantity++;
      }
    }

    // print(quantity);
    return quantity;
  }

  Future seeAllFolders() async {
    
    final appDirectory = await _localAppDirectory;
    Directory characterDirectory = Directory('${appDirectory.path}/characters');

    for (var entity in characterDirectory.listSync()) {
      if (entity is Directory) {
        debugPrint(entity.path);
      }
    }
  }


}