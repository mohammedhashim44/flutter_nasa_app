import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

class AppImage extends StatelessWidget {
  final String url;
  final BorderRadius borderRadius;

  const AppImage({
    Key? key,
    required this.url,
    this.borderRadius = BorderRadius.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Container(
        width: double.maxFinite,
        color: Colors.grey,
        child: FancyShimmerImage(
          imageUrl: url,
          boxFit: BoxFit.cover,
        ),
      ),
    );
  }
}
