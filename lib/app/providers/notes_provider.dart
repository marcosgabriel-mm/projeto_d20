
import 'package:d20_project/app/models/notes.dart';
import 'package:d20_project/app/providers/files_provider.dart';
import 'package:flutter/material.dart';

class NotesProvider extends ChangeNotifier {

  List<Notes> _notesList = [];
  List<Notes> get notesList => _notesList;

  void selectAll() {
    if (_notesList.every((note) => note.isSelected)) {
      for (var note in _notesList) {
        note.isSelected = false;
      }
    } else {
      for (var note in _notesList) {
        if (!note.isSelected) {
          note.isSelected = true;
        }
      }
    }
    notifyListeners();
  }

  void turnEveryoneUnselected() {
    for (var element in _notesList) {
      element.isSelected = false;
    }
    notifyListeners();
  }

  void selectNote(int index) {
    _notesList[index].isSelected = !_notesList[index].isSelected;
    notifyListeners();
  }

  bool areEveryoneSelected() {
    for (var element in _notesList) {
      if (!element.isSelected) {
        return false;
      }
    }
    return true;
  }

  void updateTitleDescriptionModificationDate(String newTitle, String oldTitle ,String newDescription, int index) {
   
    Notes note = _notesList[index];

    note.title = newTitle;
    note.description = newDescription;
    note.modificationDate = DateTime.now();

    FilesProvider().renameNote(_notesList[index], oldTitle);
    notifyListeners();
  }

  void addNote(String title, String description) {
    _notesList.add(
      Notes(
        title: title.isEmpty ? "Nova anotação" : title,
        description: description,
      )
    );
    FilesProvider().writeNotes(
      _notesList.last.title,
      _notesList.last.creationDate,
      _notesList.last.modificationDate,
      _notesList.last.description
    );
    //organizar por data de modificação
    notesList.sort((a, b) => b.modificationDate.compareTo(a.modificationDate));
    notifyListeners();
  }

  void removeNotes() {
    for (var note in _notesList) {
      if (note.isSelected) {
        FilesProvider().deleteNotes(note.title);
      }
    }
    _notesList.removeWhere((note) => note.isSelected);
    //organizar por data de modificação
    notesList.sort((a, b) => b.modificationDate.compareTo(a.modificationDate));
    notifyListeners();
  }

  void sortNotes(String value) {
    if (value == "Data de criação") {
          notesList.sort((a, b) => a.creationDate.compareTo(b.creationDate));
        } else if (value == "Data de modificação") {
          notesList.sort((a, b) => b.modificationDate.compareTo(a.modificationDate));
        } else {
          notesList.sort((a, b) => a.title.compareTo(b.title));
      }
    notifyListeners();
  }

  void loadNotesToList(int start) async {
    List<String> notes = await FilesProvider().readNotes(start);

    for (var i=0; i<notes.length; i+=2) {
      List<String> noteData = notes[i].split(', ');

      if (_notesList.any((element) => element.title == noteData[0])) {
        continue;
      }else{
        _notesList.add(
          Notes(
            title: noteData[0],
            creationDate: DateTime.parse(noteData[1]),
            modificationDate: DateTime.parse(noteData[2]),
            description: notes[i+1],
          )
        );
      }
    }
    //organizar por data de modificação
    notesList.sort((a, b) => b.modificationDate.compareTo(a.modificationDate));
    notifyListeners();
  }

  void loadNotesBySearch(String name) async {
    List<String> notes = await FilesProvider().searchNotesByName(name);
    _notesList.clear();


    for (var i=0; i<notes.length; i+=2) {
      List<String> noteData = notes[i].split(', ');

      if (noteData.isEmpty){
        continue;
      } else {
        _notesList.add(
          Notes(
            title: noteData[0],
            creationDate: DateTime.parse(noteData[1]),
            modificationDate: DateTime.parse(noteData[2]),
            description: notes[i+1],
          )
        );
      }

    }
    notesList.sort((a, b) => b.modificationDate.compareTo(a.modificationDate));
    notifyListeners();
  }
}