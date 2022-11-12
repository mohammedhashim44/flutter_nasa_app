import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:space_api_app/src/controllers/epic_controller.dart';
import 'package:space_api_app/src/models/epic_result.dart';
import 'package:space_api_app/src/ui/widgets/app_text.dart';
import 'package:space_api_app/src/ui/widgets/loading_widget.dart';
import 'package:space_api_app/src/ui/widgets/try_again_error_widget.dart';
import 'earth_image_widget.dart';

// EPIC : Earth Polychromatic Imaging Camera
class EPICPage extends StatefulWidget {
  const EPICPage({
    Key? key,
  }) : super(key: key);

  @override
  _EPICPageState createState() => _EPICPageState();
}

class _EPICPageState extends StateMVC<EPICPage> {
  late EPICController _con;

  _EPICPageState() : super(EPICController()) {
    _con = controller as EPICController;
  }

  @override
  void initState() {
    super.initState();
    _con.getEPICResults();
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
        _con.getEPICResults();
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
    _con.getEPICResults(dateTime: dateTime);
  }
}

class _Body extends StatefulWidget {
  final Function(DateTime dateTime) onDateChangedCallBack;
  final EPICResult result;

  const _Body(
      {Key? key, required this.result, required this.onDateChangedCallBack})
      : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late String currentImage;
  late int currentIndex;

  @override
  void initState() {
    currentIndex = 0;
    currentImage = widget.result.epicItems.elementAt(0).imageUrl;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Column(
          children: [
            AppText.normalText(
              "How Earth Looks Today",
              color: Colors.white,
              isBold: true,
              fontSize: 22,
            ),
            Expanded(
              child: Image.network(currentImage, loadingBuilder:
                  (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              }),
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 100.0,
                viewportFraction: 0.3,
                enlargeCenterPage: true,
                autoPlay: true,
                onPageChanged: (index, _) {
                  if (index != currentIndex) {
                    onImageSlided(index);
                  }
                },
              ),
              items: widget.result.epicItems.map((i) {
                return EarthImageCard(item: i);
              }).toList(),
            ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }

  void onImageSlided(int index) {
    if (index != currentIndex) {
      EPICItem item = widget.result.epicItems.elementAt(index);
      currentIndex = index;
      currentImage = item.thumbnailUrl;
      setState(() {});
    }
  }
}
