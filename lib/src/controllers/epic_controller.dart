import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:space_api_app/src/models/epic_result.dart';
import 'package:space_api_app/src/repositories/api_repository.dart';

// EPIC : Earth Polychromatic Imaging Camera
class EPICController extends ControllerMVC {
  bool loading = false;
  bool hasError = false;
  EPICResult? result;

  EPICController();

  void getEPICResults({DateTime? dateTime}) async {
    initializeLoading();

    try {
      result = await NetworkAPIRepository().getEPICPicture(dateTime: dateTime);
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
