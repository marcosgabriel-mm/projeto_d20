import 'package:d20_project/app/providers/initiatives_provider.dart';
import 'package:d20_project/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class DamageType extends StatefulWidget {

  final String damageTypeText;
  final String damageTypeSvg;
  final String damageType;

  DamageType({
    super.key, 
    required this.damageTypeText, 
    required this.damageTypeSvg, 
    required this.damageType
  });

  @override
  State<DamageType> createState() => _DamageTypeState();
}

class _DamageTypeState extends State<DamageType> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (!context.read<InitiativesProvider>().resistanceTypesSelected.contains(widget.damageTypeText) && widget.damageType == "Resistências") {
            context.read<InitiativesProvider>().resistanceTypesSelected.add(widget.damageTypeText);
          } else if (!context.read<InitiativesProvider>().weaknessTypesSelected.contains(widget.damageTypeText) && widget.damageType == "Fraquezas") {
            context.read<InitiativesProvider>().weaknessTypesSelected.add(widget.damageTypeText);
          } else {
            context.read<InitiativesProvider>().resistanceTypesSelected.remove(widget.damageTypeText);
            context.read<InitiativesProvider>().weaknessTypesSelected.remove(widget.damageTypeText);
          }
        });
      },
      child: SizedBox(
        width: 65,
        height: 55,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              widget.damageTypeSvg,
              colorFilter: 
                context.read<InitiativesProvider>().resistanceTypesSelected.contains(widget.damageTypeText) && widget.damageType == "Resistências" ? 
                  const ColorFilter.mode(Colors.white, BlendMode.srcIn) : 
                context.read<InitiativesProvider>().weaknessTypesSelected.contains(widget.damageTypeText) && widget.damageType == "Fraquezas" ? 
                  const ColorFilter.mode(Colors.white, BlendMode.srcIn) : 
                  const ColorFilter.mode(Colors.white30, BlendMode.srcIn)
            ),
            Text(
              widget.damageTypeText, 
              style: TextStyles.instance.regular.copyWith(fontSize: 12)
            ),
          ],
        ),
      ),
    );
  }
}