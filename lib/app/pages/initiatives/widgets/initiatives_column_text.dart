import 'package:d20_project/styles/text_styles.dart';
import 'package:flutter/material.dart';

class CustomTextColumn extends StatefulWidget {
  final String title;
  final String value;
  final bool isSelectionMode;
  final TextAlign alignText;
  final IconData icon;

  const CustomTextColumn({
    super.key, 
    required this.title, 
    required this.alignText, 
    required this.isSelectionMode, 
    required this.icon,
    this.value = ""
  });

  @override
  State<CustomTextColumn> createState() => _CustomTextColumnState();
}

class _CustomTextColumnState extends State<CustomTextColumn> {
  final double width = 100;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (widget.isSelectionMode) 
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 18),
                child: Icon(
                  widget.icon,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        Column(
          children: [
            SizedBox(
              width: width,
              child: Text(
                widget.title,
                textAlign: widget.title == "Iniciativa" ? widget.alignText : TextAlign.left,
                style: TextStyles.instance.regular,
              ),
            ),
            SizedBox(
              width: width,
              child: Text(
                widget.value,
                textAlign: widget.value.length > 2 ? TextAlign.left : TextAlign.center,
                style: TextStyles.instance.boldItalic,
              ),
            ),
          ],
        ),
      ],
    );
  }
}


