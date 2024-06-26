import 'package:d20_project/app/providers/d20_provider.dart';
import 'package:d20_project/styles/colors_app.dart';
import 'package:d20_project/theme/theme_config.dart';
import 'package:flutter/material.dart';

import 'package:d20_project/styles/text_styles.dart';
import 'package:provider/provider.dart';

class ApplicationBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool? areAllSelected;
  final List<Widget>? actions;
  final Function(String)? onSearch;
  final Function()? onSearchClose;
  final Function()? selectEveryObject;

  const ApplicationBar({
    super.key,
    required this.title,
    this.areAllSelected,
    this.actions, 
    this.onSearch, 
    this.onSearchClose, 
    this.selectEveryObject, 
  });

  @override
  State<ApplicationBar> createState() => _ApplicationBarState();

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}

class _ApplicationBarState extends State<ApplicationBar> {
  late D20Provider d20provider;
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    d20provider = context.watch<D20Provider>();
    return d20provider.onSearch 
    ? AppBar(
      scrolledUnderElevation: 0,
      elevation: 0,
      title: SearchBar(
        backgroundColor: WidgetStatePropertyAll(ColorsApp.instance.secondaryColor),
        leading: IconButton(
          onPressed: () {
            d20provider.toggleSearch();
            textController.clear();
            widget.onSearchClose?.call();
          },
          icon: const Icon(Icons.arrow_back)
        ),
        trailing: Iterable.generate(1).map((index) => IconButton(
          onPressed: () => textController.clear(),
          icon: const Icon(Icons.clear)
        )).toList(),
        hintText: "Pesquisar",
        autoFocus: true,
        controller: textController,
        textStyle: WidgetStatePropertyAll(TextStyles.instance.regular),
        onTapOutside: (event) => FocusScope.of(context).unfocus(), 
        onChanged: (value) => widget.onSearch!(value),
      ),
    )
    : AppBar(
      scrolledUnderElevation: 0,
      centerTitle: false,
      elevation: 0,
      title: !d20provider.isSelectionMode
        ? Padding(
            padding: const EdgeInsets.only(left: horizontalPadding),
            child: Text(widget.title, style: TextStyles.instance.regular),
          )
        : Padding(
            padding: const EdgeInsets.only(left: 9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () => widget.selectEveryObject?.call(),
                    icon: widget.areAllSelected ?? false ? const Icon(Icons.radio_button_checked) : const Icon(Icons.radio_button_off)
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text("Todos", style: TextStyles.instance.regular),
                ),
              ],
            ),
          ),
      actions: [
        Visibility(
          visible: !d20provider.isSelectionMode,
          replacement: const SizedBox.shrink(),
          child: Row(
            children: [
              if (widget.actions != null) ...widget.actions!,
            ],
          ),
        ),
      ],
    );
  }
}
