import 'package:flutter/material.dart';
import 'package:space_api_app/src/models/search_result.dart';
import 'package:space_api_app/src/ui/widgets/app_text.dart';
import 'package:space_api_app/src/ui/widgets/extended_text_widget.dart';
import 'package:space_api_app/src/ui/widgets/image_widgets/app_image_with_photo_view_widget.dart';
import 'flutter_shuttle_builder.dart';

class NasaMediaItemDetails extends StatelessWidget {
  final NasaMediaItem item;

  const NasaMediaItemDetails({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    child: Hero(
                      tag: "nasa_media_item_image_${item.nasaId}",
                      child: AppImageWithPhotoViewWidget(
                        url: item.getThumbnail()!,
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: "nasa_media_item_title_${item.nasaId}",
                      flightShuttleBuilder: flightShuttleBuilder,
                      child: AppText.normalText(
                        item.title,
                        fontSize: 22,
                        isBold: true,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    const SizedBox(height: 10),
                    AppText.normalText(
                      item.dateCreated!,
                      fontSize: 14,
                      isBold: true,
                    ),
                    const SizedBox(height: 20),
                    if (item.keywords.isNotEmpty)
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        // color: Colors.red,
                        child: Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.start,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: item.keywords.map((e) {
                            return Chip(
                              label: AppText.normalText(
                                e,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.purple,
                            );
                          }).toList(),
                        ),
                      ),
                    if (item.description != null) const SizedBox(height: 20),
                    if (item.description != null)
                      ExtendedTextWidget(
                        "Description",
                        item.description!,
                        color: Colors.black.withOpacity(0.8),
                        initialVisibleState: true,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
