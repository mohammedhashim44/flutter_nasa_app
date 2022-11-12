import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:space_api_app/src/models/apod_result.dart';
import 'package:space_api_app/src/models/epic_result.dart';
import 'package:space_api_app/src/models/search_result.dart';

String searchEndPoint = "https://images-api.nasa.gov/search?q=query";

String apodEndPoint =
    "https://api.nasa.gov/planetary/apod?api_key=API_KEY&date=DATE";

String epicEndPoint =
    "https://api.nasa.gov/EPIC/api/natural?api_key=API_KEY&date=DATE";
String epicImageAssetPath =
    "https://epic.gsfc.nasa.gov/archive/natural/YEAR/MONTH/DAY/EXT/IMAGE_FILE";

String marsRoversEndPoint =
    "https://api.nasa.gov/mars-photos/api/v1/rovers?api_key=API_KEY";

const String apiKey = "DEMO_KEY";

abstract class APIRepository {
  Future<SearchResult> performSearch(String searchString);

  Future<APODResult> getPictureOfTheDay();

  Future<EPICResult> getEPICPicture({DateTime? dateTime});
}

class NetworkAPIRepository implements APIRepository {
  late Dio dio;

  NetworkAPIRepository() {
    dio = Dio();
  }

  @override
  Future<SearchResult> performSearch(String searchString) async {
    String searchPath = searchEndPoint.replaceFirst("query", searchString);
    Response response = await dio.get(searchPath);
    SearchResult searchResult = SearchResult.fromJson(response.data);
    return searchResult;
  }

  // Helper Function
  Future<List<String>> getMediaLinks(String href) async {
    Response response = await dio.get(href);
    List<String> x = response.data.cast<String>();
    return x;
  }

  @override
  Future<APODResult> getPictureOfTheDay({DateTime? dateTime}) async {
    late DateTime _dateTime;
    if (dateTime != null) {
      _dateTime = dateTime;
    } else {
      _dateTime = DateTime.now();
    }

    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(_dateTime);

    String fullPath = apodEndPoint
        .replaceAll("API_KEY", apiKey)
        .replaceAll("DATE", formattedDate);

    Response response = await dio.get(fullPath);
    APODResult result = APODResult.fromJson(response.data);
    return result;
  }

  @override
  Future<EPICResult> getEPICPicture({DateTime? dateTime}) async {
    late DateTime _dateTime;
    if (dateTime != null) {
      _dateTime = dateTime;
    } else {
      _dateTime = DateTime.now();
    }

    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(_dateTime);

    String fullPath = epicEndPoint
        .replaceAll("API_KEY", apiKey)
        .replaceAll("DATE", formattedDate);

    Response response = await dio.get(fullPath);
    EPICResult epicResult = EPICResult.fromJson(response.data);
    return epicResult;
  }
}
