import 'package:d20_project/app/providers/notes_provider.dart';
import 'package:d20_project/styles/colors_app.dart';
import 'package:d20_project/styles/text_styles.dart';
import 'package:d20_project/theme/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



// ignore: must_be_immutable
class NotesText extends StatefulWidget {
  NotesText({
    super.key, 
    this.noteTitle = "", 
    this.noteDescription = "",
    required this.index
  });

  String noteTitle;
  String noteDescription;
  final int index;

  @override
  State<NotesText> createState() {
    return _NotesTextState();
  }

}

class _NotesTextState extends State<NotesText> {
  late NotesProvider notesProvider;
  late final TextEditingController _tittleNoteController;
  late final TextEditingController _descriptionController;
  String _oldTitle="";

  @override
  void initState() {
    super.initState();
    _oldTitle = widget.noteTitle;
    _tittleNoteController = TextEditingController(text: widget.noteTitle);
    _descriptionController = TextEditingController(text: widget.noteDescription);
  }
  
  @override
  Widget build(BuildContext context) {
    notesProvider = context.watch<NotesProvider>();
    return PopScope(
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        if (widget.index != -1) {
          notesProvider.updateTitleDescriptionModificationDate(_tittleNoteController.text, _oldTitle,_descriptionController.text, widget.index);
          // FilesProvider().readNotes();
        } else if (_tittleNoteController.text.isEmpty && _descriptionController.text.isEmpty) {
          return Navigator.pop(context);
        } else {
          notesProvider.addNote(_tittleNoteController.text, _descriptionController.text);
        }
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    if (widget.index != -1) {
                      notesProvider.updateTitleDescriptionModificationDate(_tittleNoteController.text, _oldTitle, _descriptionController.text, widget.index);
                      // FilesProvider().readNotes();
                    } else if (_tittleNoteController.text.isEmpty && _descriptionController.text.isEmpty) {
                      return Navigator.pop(context);  
                    } else {
                      notesProvider.addNote(_tittleNoteController.text, _descriptionController.text);
                    }
                    return Navigator.pop(context);
                  },
                  icon: const Icon(Icons.done),
                )
              ],
              automaticallyImplyLeading: false,
              centerTitle: false,
              title: _editingTitle(),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(0.0),
                child: Container(
                  color: Colors.white30,
                  height: 1.0,
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            children: [
              const SizedBox(height: verticalPadding),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorsApp.instance.primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: _descriptionController,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(0),
                      border: InputBorder.none,
                      hintText: "Escreva sua descrição aqui...",
                      hintStyle: TextStyles.instance.regular.copyWith(color: Colors.white30),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                    onSubmitted: (value) {
                      setState(() {
                        widget.noteDescription = value;
                        _descriptionController.text = value;
                      });
                    },
                    style: TextStyles.instance.regular,
                    maxLines: null,
                  ),
                ),
              ),
              const SizedBox(height: verticalPadding),
            ],
          ),
        )
      ),
    );
  }

  Widget _editingTitle() {
    return TextField(
      cursorColor: Colors.white,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(0),
        hintText: "Título",
        hintStyle: TextStyles.instance.regular.copyWith(color: Colors.white30),
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
      controller: _tittleNoteController,
      autofocus: widget.index != -1 ? false : true,
      style: TextStyles.instance.regular,
      onSubmitted: (value) {
        setState(() {
          widget.noteTitle = value;
          _tittleNoteController.text = value;
        });
      },
      onChanged: (value) {
        setState(() {
          widget.noteTitle = value;
          _tittleNoteController.text = value;
        });
      },
    );
  }
}