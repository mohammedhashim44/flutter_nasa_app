import 'package:flutter/material.dart';
import 'package:space_api_app/src/models/search_result.dart';
import 'package:space_api_app/src/ui/widgets/app_text.dart';
import 'package:space_api_app/src/ui/widgets/image_widgets/app_image_widget.dart';
import 'flutter_shuttle_builder.dart';
import 'nasa_media_item_details_page.dart';
import 'dart:math' as math;

class NasaMediaItemCard extends StatelessWidget {
  final NasaMediaItem item;

  const NasaMediaItemCard({Key? key, required this.item}) : super(key: key);

  Color randomColor() {
    return Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
        .withOpacity(1.0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClicked(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 200,
            child: Hero(
              tag: "nasa_media_item_image_${item.nasaId}",
              child: AppImage(
                url: item.hasThumbnails()
                    ? item.getThumbnail()!
                    : (item.getLargestImage() ?? ""),
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Hero(
            tag: "nasa_media_item_title_${item.nasaId}",
            flightShuttleBuilder: flightShuttleBuilder,
            child: AppText.normalText(
              item.title,
              fontSize: 18,
              isBold: true,
              textAlign: TextAlign.start,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  void onClicked(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NasaMediaItemDetails(item: item),
      ),
    );
  }
}
