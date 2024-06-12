import 'package:d20_project/app/providers/filter_provider.dart';
import 'package:d20_project/styles/text_styles.dart';
import 'package:d20_project/theme/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class FilterOptions extends StatefulWidget {
  final String tileTittle;
  final List<String> tileDescriptionTitle;

  const FilterOptions({
    super.key, 
    required this.tileTittle, 
    required this.tileDescriptionTitle, 
  });

  @override
  State<FilterOptions> createState() => _FilterOptionsState();
}

class _FilterOptionsState extends State<FilterOptions> {

  late FilterProvider filterProvider;

  @override
  Widget build(BuildContext context) {
    filterProvider = context.watch<FilterProvider>();
    return ExpansionTile(
      title: Row(
        children: [
          //todo mudar svgs
          SvgPicture.asset("assets/svg/filters/class.svg"),
          Padding(
            padding: const EdgeInsets.only(left: horizontalPadding),
            child: Text(widget.tileTittle, style: TextStyles.instance.regular,),
          ),
        ],
      ),
      childrenPadding: const EdgeInsets.symmetric(vertical: verticalPadding),
      children: [
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          spacing: horizontalPadding,
          runSpacing: verticalPadding*2,
          children: [
            for (var index = 0; index < widget.tileDescriptionTitle.length; index++)
            GestureDetector(
              onTap: () {
                filterProvider.selectFilter(widget.tileDescriptionTitle[index]);
              },
              child: SizedBox(
                width: 150,
                child: Row(
                  children: [
                    Icon(filterProvider.selected.contains(widget.tileDescriptionTitle[index]) ? Icons.radio_button_on : Icons.radio_button_off),
                    Padding(
                      padding: const EdgeInsets.only(left: horizontalPadding),
                      child: SizedBox(
                        width: 100,
                        child: Text(
                          widget.tileDescriptionTitle[index], 
                          style: TextStyles.instance.regular,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}