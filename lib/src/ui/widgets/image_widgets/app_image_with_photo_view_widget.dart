import 'package:flutter/material.dart';
import 'package:space_api_app/src/ui/widgets/image_widgets/app_image_widget.dart';
import 'package:space_api_app/src/ui/widgets/image_widgets/photo_view_widget.dart';

class AppImageWithPhotoViewWidget extends StatelessWidget {
  final String url;
  final BorderRadius borderRadius;

  const AppImageWithPhotoViewWidget({
    Key? key,
    required this.url,
    this.borderRadius = BorderRadius.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onImageClicked(context),
      child: AppImage(
        url: url,
        borderRadius: borderRadius,
      ),
    );
  }

  void onImageClicked(BuildContext _) {
    Navigator.push(
      _,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          body: PhotoViewWidget(
            url: url,
          ),
        ),
      ),
    );
  }
}
