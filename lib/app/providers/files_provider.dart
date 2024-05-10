import 'dart:io';
import 'package:path_provider/path_provider.dart';

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

  //TODO - implementar a função de salvar, deletar e ler dados

  //TODO - implementar a função de ler, salvar e deletar magias
}