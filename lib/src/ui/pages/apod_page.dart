import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:space_api_app/src/controllers/apod_controller.dart';
import 'package:space_api_app/src/models/apod_result.dart';
import 'package:space_api_app/src/ui/widgets/app_text.dart';
import 'package:space_api_app/src/ui/widgets/extended_text_widget.dart';
import 'package:space_api_app/src/ui/widgets/image_widgets/app_image_with_photo_view_widget.dart';
import 'package:space_api_app/src/ui/widgets/loading_widget.dart';
import 'package:space_api_app/src/ui/widgets/try_again_error_widget.dart';
import 'package:space_api_app/src/ui/widgets/video_players/network_video_player.dart';
import 'package:space_api_app/src/ui/widgets/video_players/youtube_video_player.dart';

// APOD : Astronomy Picture Of The Day
class APODPage extends StatefulWidget {
  const APODPage({
    Key? key,
  }) : super(key: key);

  @override
  _APODPageState createState() => _APODPageState();
}

class _APODPageState extends StateMVC<APODPage> {
  late APODController _con;

  _APODPageState() : super(APODController()) {
    _con = controller as APODController;
  }

  @override
  void initState() {
    super.initState();
    _con.getPictureOfTheDay(dateTime: getPreviousDayDateTime());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getCurrentWidget(),
    );
  }

  Widget getCurrentWidget() {
    if (_con.loading) {
      return const LoadingWidget();
    }
    if (_con.hasError) {
      return TryAgainErrorWidget(onTryAgainClicked: () {
        _con.getPictureOfTheDay();
      });
    }
    if (_con.result == null) {
      return const Center();
    }
    return _Body(
      result: _con.result!,
      onDateChangedCallBack: onDateTimeChanged,
    );
  }

  void onDateTimeChanged(DateTime dateTime) {
    _con.getPictureOfTheDay(dateTime: dateTime);
  }
}

class _Body extends StatelessWidget {
  final Function(DateTime dateTime) onDateChangedCallBack;
  final APODResult result;

  const _Body(
      {Key? key, required this.result, required this.onDateChangedCallBack})
      : super(key: key);

// method to check if url is youtube or not
  bool isYoutubeUrl(String url) {
    return url.contains("youtube.com") || url.contains("youtu.be");
  }

  Widget getMediaWidget() {
    if (result.isVideo()) {
      if (isYoutubeUrl(result.url)) {
        return YoutubeVideoPlayerWidget(url: result.url);
      } else {
        return NetworkVideoPlayerWidget(url: result.url);
      }
    } else {
      return AppImageWithPhotoViewWidget(
        url: result.url,
        borderRadius: BorderRadius.circular(20.0),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            getMediaWidget(),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.normalText(
                    result.title,
                    fontSize: 28,
                    isBold: true,
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 20),
                  if (result.copyright != null)
                    AppText.normalText(
                      "Copyright: ${result.copyright}",
                      fontSize: 16,
                      textAlign: TextAlign.start,
                    ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      AppText.normalText(
                        result.date,
                        fontSize: 14,
                        isBold: true,
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () => onTryAnotherDateClicked(context),
                        child: const Text("Try Another Date"),
                        style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder()),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (result.explanation.trim().isNotEmpty)
                    ExtendedTextWidget(
                      "Explanation",
                      result.explanation,
                      color: Colors.black.withOpacity(0.8),
                      initialVisibleState: true,
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onTryAnotherDateClicked(BuildContext context) async {
    // make initial date the date of current item
    late DateTime initialDateTime;
    try {
      initialDateTime = DateTime.parse(result.date);
    } catch (e) {
      initialDateTime = getPreviousDayDateTime();
    }

    final DateTime? pickedDateTime = await showDatePicker(
      context: context,
      initialDate: initialDateTime,
      firstDate: DateTime(1995, 6, 16),
      lastDate: getPreviousDayDateTime(),
    );
    if (pickedDateTime != null) {
      onDateChangedCallBack(pickedDateTime);
    }
  }
}

DateTime getPreviousDayDateTime() {
  DateTime dateTime = DateTime.now();
  DateTime previousDayDateTime = dateTime.subtract(const Duration(days: 1));
  return previousDayDateTime;
}
