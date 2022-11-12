import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:space_api_app/src/ui/pages/bottom_navigation_screen/bottom_navigation_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nasa App',
      debugShowCheckedModeBanner: true,
      theme: FlexColorScheme.light(
        colors: FlexColor.schemes[FlexScheme.material]!.light,
        fontFamily: "Poppins",
      ).toTheme,
      home: const BottomNavigationScreen(),
    );
  }
}
