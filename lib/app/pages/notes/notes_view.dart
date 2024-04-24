import 'package:d20_project/app/pages/notes/widgets/custom_column_for_notes.dart';
import 'package:d20_project/app/pages/notes/widgets/notes_text.dart';
import 'package:d20_project/app/providers/d20_provider.dart';
import 'package:d20_project/app/providers/notes_provider.dart';
import 'package:d20_project/app/widgets/appbar.dart';
import 'package:d20_project/app/widgets/selection_bottom_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotesView extends StatefulWidget {
  const NotesView({
    super.key,
  });

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  late D20Provider d20provider;
  late NotesProvider notesProvider;

  @override
  Widget build(BuildContext context) {
    d20provider = context.watch<D20Provider>();
    notesProvider = context.watch<NotesProvider>();

    return WillPopScope(
      onWillPop: () async {
        if (d20provider.isSelectionMode) {
          d20provider.toogleSelectionMode();
          d20provider.turnOffOrOnBottomBar();
          notesProvider.turnEveryoneUnselected();
          // notesProvider.turnAllSelecetedOrUnselected();
          return false;
        }
        return true;
      },
      child: Scaffold(
        bottomNavigationBar: !d20provider.isSelectionMode ? const SizedBox.shrink() : const SelectionBottomMenu( textLabel: ["Excluir"], icons: [Icons.delete]),
        appBar: ApplicationBar(
            title: "Anotações",
            listOfSorts: const ["Data de criação", "Data de modificação", "Nome"],
            areAllSelected: d20provider.areAllSelectedFromThatScreen("Anotações", context),
          ),
        body: ListView.builder(
            itemCount: notesProvider.notesList.length,
            itemBuilder: (context, index) => ElevatedButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  alignment: Alignment.centerLeft,
                ),
                onPressed: () {
                  if (d20provider.isSelectionMode){
                    context.read<NotesProvider>().selectNote(index); 
                  } else {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context) => NotesText(
                          index: index,
                          noteTitle: notesProvider.notesList[index].title,
                          noteDescription: notesProvider.notesList[index].description,
                        ),
                      ),
                    );
                  }
                },
                onLongPress: () { 
                  d20provider.toogleSelectionMode(); 
                  d20provider.turnOffOrOnBottomBar();
                  context.read<NotesProvider>().selectNote(index); 
                },
                child: NotesRow(
                  title: notesProvider.notesList[index].title,
                  description: notesProvider.notesList[index].description,
                  modificationDate: notesProvider.notesList[index].modificationDate,
                  icon: notesProvider.notesList[index].isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                )
            )
          ),
      ),
    );
  }
}
