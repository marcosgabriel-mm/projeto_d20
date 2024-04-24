import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FilesProvider {

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    print(directory.path);
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/notes.txt');
  }

  Future<File> writeNotes(String noteTitle, DateTime creationDate, DateTime modificationDate, String description) async {
    final file = await _localFile;
    return file.writeAsString('$noteTitle, $creationDate, $modificationDate,\n$description');
  }

  Future<String> readNotes() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      return "";
    }
  }
}