import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:space_api_app/src/models/apod_result.dart';
import 'package:space_api_app/src/repositories/api_repository.dart';

// APOD : Astronomy Picture Of The Day
class APODController extends ControllerMVC {
  bool loading = false;
  bool hasError = false;
  APODResult? result;

  APODController();

  void getPictureOfTheDay({DateTime? dateTime}) async {
    initializeLoading();

    try {
      result =
          await NetworkAPIRepository().getPictureOfTheDay(dateTime: dateTime);
      setState(() {
        loading = false;
      });
    } catch (e) {
      endLoadingWithError();
    }
  }

  void initializeLoading() {
    setState(() {
      loading = true;
      result = null;
      hasError = false;
    });
  }

  void endLoadingWithError() {
    setState(() {
      loading = false;
      hasError = true;
    });
  }
}
