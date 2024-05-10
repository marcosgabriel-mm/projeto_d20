import 'package:d20_project/app/pages/notes/widgets/custom_column_for_notes.dart';
import 'package:d20_project/app/pages/notes/widgets/notes_text.dart';
import 'package:d20_project/app/providers/d20_provider.dart';
import 'package:d20_project/app/providers/files_provider.dart';
import 'package:d20_project/app/providers/notes_provider.dart';
import 'package:d20_project/app/utils/add_functions.dart';
import 'package:d20_project/app/utils/sort_functions.dart';
import 'package:d20_project/app/widgets/add_button.dart';
import 'package:d20_project/app/widgets/appbar.dart';
import 'package:d20_project/app/widgets/selection_bottom_menu.dart';
import 'package:d20_project/app/widgets/sort_button.dart';
import 'package:d20_project/styles/text_styles.dart';
import 'package:d20_project/theme/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class NotesView extends StatefulWidget {
  const NotesView({
    super.key,
  });

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  final FilesProvider filesProvider = FilesProvider();
  final ScrollController _scrollController = ScrollController();
  late D20Provider d20provider;
  late NotesProvider notesProvider;

  int start = 0;

  @override
  void initState() {
    super.initState();
    context.read<NotesProvider>().loadNotesToList(start);
    _scrollController.addListener(_loadMoreNotes);
  }

  void _loadMoreNotes(){
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      setState(() {
        start += 5;
        context.read<NotesProvider>().loadNotesToList(start);
      });
    }
  }

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
          return false;
        }
        return true;
      },
      child: Scaffold(
        bottomNavigationBar: !d20provider.isSelectionMode ? const SizedBox.shrink() : const SelectionBottomMenu( textLabel: ["Excluir"], icons: [Icons.delete]),
        appBar: ApplicationBar(
            title: context.read<D20Provider>().currentRoute,
            actions: [
              IconButton(
                onPressed: (){}, 
                icon: const Icon(Icons.search, color: Colors.white,)
              ),
              AddButton(
                function: AddFunctions.addSomethingAccordingToScreen(context),
              ),
              Padding(
                padding: const EdgeInsets.only(right: horizontalPadding),
                child: SortButton(
                  listOfSorts: const ["Data de criação", "Data de modificação", "Nome"],
                  padding: horizontalPadding,
                  function: (value) {
                    if (value != null) {
                      SortFunctions.verifyScreenToSort(value,context);
                    }
                  },
                ),
              )
            ],
            areAllSelected: d20provider.areAllSelectedFromThatScreen(context),
          ),
        body: notesProvider.notesList.isEmpty 
          ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/svg/Papigrafo.svg"),
                const SizedBox(height: 36),
                Text(
                  "Nada anotado ainda!",
                  style: TextStyles.instance.regular,
                )
              ],
            ),
          )
          :ListView.builder(
            itemCount: notesProvider.notesList.length,
            controller: _scrollController,
            itemBuilder: (context, index) => ListTile(              
                onTap: () {
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
                title: NotesRow(
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
