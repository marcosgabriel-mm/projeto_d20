import 'package:d20_project/app/providers/d20_provider.dart';
import 'package:d20_project/styles/text_styles.dart';
import 'package:d20_project/theme/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotesRow extends StatelessWidget {
  NotesRow({
      super.key,
      required this.title,
      required this.description,
      required this.modificationDate, 
      required this.icon      
    });

  final String title;
  final String description;
  final IconData icon;
  final DateTime modificationDate;

  final List<String> months = [
    '',
    'Jan.',
    'Fev.',
    'Mar.',
    'Abr.',
    'Mai.',
    'Jun.',
    'Jul.',
    'Ago.',
    'Set.',
    'Out.',
    'Nov.',
    'Dez.',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: verticalPadding),
      padding: const EdgeInsets.fromLTRB(horizontalPadding, verticalPadding, horizontalPadding, verticalPadding),
      alignment: AlignmentDirectional.centerStart,
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.white60, width: 1))),
      child: Row(
        children: [
          if (context.read<D20Provider>().isSelectionMode) 
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 18),
                  child: Icon(
                    icon,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyles.instance.regular),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    description,
                    style: TextStyles.instance.regular.copyWith(fontSize: 12),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                        "${modificationDate.day} de ${months[modificationDate.month]} de ${modificationDate.year}",
                        style: TextStyles.instance.regular.copyWith(fontSize: 12, color: Colors.white30),
                        textAlign: TextAlign.end),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
