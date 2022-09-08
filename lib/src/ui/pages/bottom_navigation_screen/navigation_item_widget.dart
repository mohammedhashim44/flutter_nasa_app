import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

class NavigationItemWidget extends StatelessWidget {
  final String svgPath;
  final bool isSelected;

  const NavigationItemWidget(
      {Key? key, required this.svgPath, this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(13),
        ),
        color: isSelected
            ? Theme.of(context).bottomNavigationBarTheme.selectedItemColor
            : Colors.transparent,
      ),
      child: SvgPicture.asset(
        svgPath,
        height: 20,
      ),
    );
  }
}
