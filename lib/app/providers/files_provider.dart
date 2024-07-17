import 'dart:async';
import 'dart:io';
import 'package:d20_project/app/models/character.dart';
import 'package:d20_project/app/models/notes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  //* Notes section

  Future<File> noteFile(String noteTitle) async {
    final appDirectory = await _localAppDirectory;
    Directory directory = Directory('${appDirectory.path}/notes');

    if (!await directory.exists()) {
      await directory.create();
    }

    return File('${directory.path}/$noteTitle.txt');
  }

  void printAllNotes() async {
    final appDirectory = await _localAppDirectory;
    Directory directory = Directory('${appDirectory.path}/notes');

    for (var entity in directory.listSync()) {
      if (entity is File) {
        debugPrint(entity.path);
      }
    }
  }

  void deleteAllNotes() async {
    final appDirectory = await _localAppDirectory;
    Directory directory = Directory('${appDirectory.path}/notes');

    if (await directory.exists()) {
      await directory.delete(recursive: true);
    }
  }

  Future<void> renameNote(Notes note, String oldTitle) async {
    final file = await noteFile(oldTitle);

    if (file.existsSync()) {
      await file.delete();
      writeNotes(note.title, note.creationDate, note.modificationDate, note.description);
    }

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

  //* Characters section

  Future getJson(int index) async {
    
    Directory directory = Directory('${(await _localAppDirectory).path}/characters/CHAR$index');
    File jsonFile = File("");

    for (var entity in directory.listSync()) {
      if (entity is File && entity.path.endsWith('.json')) {
        jsonFile = entity;
        break;
      }
    }

    String jsonString = await jsonFile.readAsString();
    Map<String, dynamic> json = jsonDecode(jsonString);
    return json;
  }

  Future getCharacterFiles(int characterId) async {
    
    final appDirectory = await _localAppDirectory;
    Directory characterDirectory = Directory('${appDirectory.path}/characters/CHAR$characterId');
    Map<String, String> files = {};

    if(await characterDirectory.exists()){
      for (var entity in characterDirectory.listSync()) {
        if (entity is File) {
          if (entity.path.endsWith('.json')) {
            files['json'] = entity.path.toString();
          } else if (entity.path.endsWith('.jpg') || entity.path.endsWith('.png')) {
            files['photo'] = entity.path;
          }
        }
      }
    }
    return files;
  }

  Future saveCharacter(Character character, int index) async {

    final  appDirectory = await  _localAppDirectory;
    int quantity = await getCharactersQuantityInPath();

    if (index.isNegative) {

      try {
        Directory characterDirectory = Directory('${appDirectory.path}/characters/CHAR$quantity');

        if (!await characterDirectory.exists()) {
          await characterDirectory.create();
        }
       
        File jsonFile = File('${characterDirectory.path}/${character.name}_${character.classType}_${character.currentHitPoints}_${character.level}.json');
        await jsonFile.writeAsString(jsonEncode(character.toJson()));

        ByteData data = await rootBundle.load("assets/images/addcharacter.png");
        List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

        File imageFile = File('${characterDirectory.path}/character_photo_$quantity.jpg');
        await imageFile.writeAsBytes(bytes);
      }
      catch (e) {
        debugPrint('Erro ao salvar arquivo: $e');
      }

    } else {
      
      try {
        Directory characterDirectory = Directory('${appDirectory.path}/characters/CHAR$index');

        if (!await characterDirectory.exists()) {
          await characterDirectory.create();
        }
        
        List<FileSystemEntity> files = characterDirectory.listSync();
        for (var file in files) {
          if (file is File && file.path.endsWith('.json')) {
            await file.delete();
          }
        }

        File jsonFile = File('${characterDirectory.path}/${character.name}_${character.classType}_${character.currentHitPoints}_${character.level}.json');
        await jsonFile.writeAsString(jsonEncode(character.toJson()));
      }
      catch (e) {
        debugPrint('Erro ao salvar arquivo: $e');
      }
    }
  }
  
  Future deleteCharacter(int characterId) async {

    final appDirectory = await _localAppDirectory;
    Directory oldCharacterDirectory = Directory('${appDirectory.path}/characters/CHAR$characterId');

    if (await oldCharacterDirectory.exists()) {
      await oldCharacterDirectory.delete(recursive: true);
    }

    int quantity = await getCharactersQuantityInPath();
    for (int newIndex = characterId; newIndex < quantity; newIndex++) {
      Directory characterDirectory = Directory('${appDirectory.path}/characters/CHAR${newIndex+1}');
      if (await characterDirectory.exists()) {
        String newPath = '${appDirectory.path}/characters/CHAR$newIndex';
        characterDirectory.renameSync(newPath);
      }
    }
  }

  Future<void> saveNewPhoto(int characterId) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final appDirectory = await _localAppDirectory;
      
      Directory characterDirectory = Directory('${appDirectory.path}/characters/CHAR$characterId');
      if (!await characterDirectory.parent.exists()) {
        await characterDirectory.parent.create();
      }

      if (!await characterDirectory.exists()) {
        await characterDirectory.create();
      }

      var files = characterDirectory.listSync();
      for (var file in files) {
        if (file is File) {
          if (path.extension(file.path) == '.jpg' || path.extension(file.path) == '.png') {
            await file.delete();
          }
        }
      }

      File imageFile = File(pickedFile.path);
      await imageFile.copy('${characterDirectory.path}/character_photo_$characterId.jpg');
    }
  }

  Future getCharactersQuantityInPath() async {
  
    final appDirectory = await _localAppDirectory;
    Directory characterDirectory = Directory('${appDirectory.path}/characters');
    int quantity = 0;

    if (! await characterDirectory.exists()) {
      await characterDirectory.create();
    }

    for (var entity in characterDirectory.listSync()) {
      if (entity is Directory) {
        debugPrint(entity.path);
        quantity++;
      }
    }

    return quantity;
  }

  Future seeAllFolders() async {
    
    final appDirectory = await _localAppDirectory;
    Directory characterDirectory = Directory('${appDirectory.path}/characters');
    // debugPrint(characterDirectory.path);

    for (var entity in characterDirectory.listSync()) {
      if (entity is Directory) {
        debugPrint(entity.path);
      }
    }
  }

  //* Attacks section

  Future saveAttacks(List<Map<String, String>> listOfAttacks) async {

    final appDirectory = await _localAppDirectory;
    Directory attacksDirectory = Directory('${appDirectory.path}/attacks');

    if (!await attacksDirectory.exists()) {
      await attacksDirectory.create();
    }

    if (await attacksDirectory.exists()) {
      File attacksFile = File('${attacksDirectory.path}/attacks.json');
      await attacksFile.writeAsString(jsonEncode(listOfAttacks));
    }
  }

  Future loadAttacks() async {
    try {
      final appDirectory = await _localAppDirectory;
      Directory attacksDirectory = Directory('${appDirectory.path}/attacks');

      if (!await attacksDirectory.exists()) {
        await attacksDirectory.create(recursive: true);
      }

      File attacksFile = File('${attacksDirectory.path}/attacks.json');

      if (await attacksFile.exists()) {
        String contents = await attacksFile.readAsString();
        return jsonDecode(contents);
      } else {
        return [];
      }
    } catch (e) {
      debugPrint('Erro ao carregar ataques: $e');
      return [];
    }
  }

}