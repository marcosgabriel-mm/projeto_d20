import 'package:d20_project/styles/text_styles.dart';
import 'package:flutter/material.dart';

class TextFields extends StatefulWidget {
  final double fontSize;
  final ValueChanged<String> onTextChanged;
  final String? text;

  const TextFields({
    super.key, 
    this.text, 
    required this.fontSize, 
    required this.onTextChanged, 
  });

  @override
  State<TextFields> createState() => _TextFieldsState();
}

class _TextFieldsState extends State<TextFields> {
  final TextEditingController _controller = TextEditingController();
  String valueText = "";

  @override
  void initState() {
    super.initState();
    valueText = widget.text ?? "   ";
    _controller.text = widget.text ?? "   ";
  }

  @override
  void didUpdateWidget(covariant TextFields oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.text != oldWidget.text) {
      _controller.text = widget.text ?? "   ";
    }
  }

  @override
  Widget build(BuildContext context) {
    final textPainter = TextPainter(
      text: TextSpan(text: widget.text, style: TextStyles.instance.regular.copyWith(fontSize: widget.fontSize)),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);

    return SizedBox(
      width: textPainter.size.width+3,
      child: TextField(
        controller: _controller,
        style: TextStyles.instance.regular.copyWith(fontSize: widget.fontSize.toDouble()),
        textAlign: TextAlign.center,
        onTapOutside: (value) => FocusScope.of(context).unfocus(),
        onChanged: (value) {
          setState(() {
            valueText = value;
          });
          widget.onTextChanged(value);
        },
        cursorColor: Colors.white,
        decoration: const InputDecoration(
          border: InputBorder.none,
          disabledBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.zero
        ),
      ),
    );
  }
}