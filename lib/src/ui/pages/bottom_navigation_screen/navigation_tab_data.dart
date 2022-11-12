import 'package:flutter/material.dart';
import 'package:space_api_app/src/ui/pages/about_page.dart';
import 'package:space_api_app/src/ui/pages/apod_page.dart';
import 'package:space_api_app/src/ui/pages/epic_page/epic_page.dart';
import 'package:space_api_app/src/ui/pages/search_page/search_page.dart';

class NavigationItemData {
  final String svgPath;
  final String label;
  final Widget page;

  NavigationItemData(this.svgPath, this.label, this.page);
}

var navigationItemsData = [
  NavigationItemData("assets/icons/astronomy.svg", "APOD", const APODPage()),
  NavigationItemData("assets/icons/earth.svg", "EPIC", const EPICPage()),
  NavigationItemData("assets/icons/search.svg", "Search", const SearchPage()),
  NavigationItemData("assets/icons/about.svg", "About", const AboutPage()),
];
