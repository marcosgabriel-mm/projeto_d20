import 'package:d20_project/app/pages/filters/widgets/filter_options.dart';
import 'package:d20_project/app/providers/filter_provider.dart';
import 'package:d20_project/styles/text_styles.dart';
import 'package:d20_project/theme/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterView extends StatelessWidget {
  final Map<dynamic, dynamic> filters;
  const FilterView({super.key, required this.filters});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: AppBar(
            title: Text('Filtros', style: TextStyles.instance.regular,),
            centerTitle: true,
            scrolledUnderElevation: 0,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context, context.read<FilterProvider>().selected);
                },
                icon: const Icon(Icons.done),
              )
            ],
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: filters.length,
        padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
        itemBuilder: (context, index) {
          return FilterOptions(
            tileTittle: filters.keys.elementAt(index),
            tileDescriptionTitle: filters.values.elementAt(index),
          );
        },
      )
    );
  }
}