
import 'package:d20_project/app/models/notes.dart';
import 'package:d20_project/app/providers/files_provider.dart';
import 'package:flutter/material.dart';

class NotesProvider extends ChangeNotifier {

  List<Notes> _notesList = [
      Notes(
        title: "Anotação 1",
        description: "Descrição da anotação 1",
        isSelected: false
      ),
      Notes(
        title: "Anotação 2",
        description: "Descrição da anotação 2",
        isSelected: false
      ),
  ];

  List<Notes> get notesList => _notesList;

  void selectOrUnselectAll() {
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

  void updateTitleDescriptionModificationDate(String newTitle, String newDescription, int index) {
    _notesList[index].title = newTitle;
    _notesList[index].description = newDescription;
    _notesList[index].modificationDate = DateTime.now();
    FilesProvider().writeNotes(
      _notesList[index].title,
      _notesList[index].creationDate,
      _notesList[index].modificationDate,
      _notesList[index].description
    );
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
    notifyListeners();
  }

  void removeNotes() {
    _notesList.removeWhere((note) => note.isSelected);
    notifyListeners();
  }

  void sortNotes(String value) {
    if (value == "Data de criação") {
          notesList.sort((a, b) => a.creationDate.compareTo(b.creationDate));
        } else if (value == "Data de modificação") {
          notesList.sort((a, b) => a.modificationDate.compareTo(b.modificationDate));
        } else {
          notesList.sort((a, b) => a.title.compareTo(b.title));
      }
    notifyListeners();
  }
}