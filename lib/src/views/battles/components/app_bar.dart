import 'package:d20_project/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BarraAplicativo extends StatelessWidget implements PreferredSizeWidget {
  const BarraAplicativo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:16),
      child: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SvgPicture.asset(
              "assets/svg/Iniciativa.svg",
              fit: BoxFit.cover,
              width: 25,
              height: 25,
            ),
            const SizedBox(height: 8),
            Text("INICIATIVAS", style: TextStyles.instance.regular)
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight+10);
}



          
           