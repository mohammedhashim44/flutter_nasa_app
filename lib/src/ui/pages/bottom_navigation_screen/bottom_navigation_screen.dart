import 'package:flutter/material.dart';
import 'package:space_api_app/src/ui/pages/bottom_navigation_screen/navigation_item_widget.dart';
import 'package:space_api_app/src/ui/pages/bottom_navigation_screen/navigation_tab_data.dart';
import 'dart:math' as math;

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({Key? key}) : super(key: key);

  @override
  _BottomNavigationScreenState createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = 0;
  }

  String imageUrl =
      'https://images.unsplash.com/photo-1465572089651-8fde36c892dd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80';

  Color randomColor() {
    return Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
        .withOpacity(1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (newIndex) {
          setState(() {
            selectedIndex = newIndex;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: navigationItemsData.map((item) {
          int index = navigationItemsData.indexOf(item);
          return BottomNavigationBarItem(
            icon: NavigationItemWidget(
              svgPath: item.svgPath,
              isSelected: index == selectedIndex,
            ),
            label: item.label,
          );
        }).toList(),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(seconds: 1),
        child: IndexedStack(
          children: navigationItemsData.map((e) => e.page).toList(),
          index: selectedIndex,
        ),
      ),
    );
  }

  Widget getBody() {
    return navigationItemsData.elementAt(selectedIndex).page;
  }
}
