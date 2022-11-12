import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:space_api_app/src/models/search_result.dart';
import 'package:space_api_app/src/repositories/api_repository.dart';

class SearchController extends ControllerMVC {
  bool loading = false;
  bool hasError = false;
  SearchResult? searchResult;

  int resultLimit = 20;

  SearchController();

  void search(String searchString) async {
    setState(() {
      loading = true;
      hasError = false;
    });

    try {
      searchResult = await NetworkAPIRepository().performSearch(searchString);
      if (searchResult!.nasaMediaItems.length > resultLimit) {
        searchResult!.nasaMediaItems =
            searchResult!.nasaMediaItems.sublist(0, resultLimit);
      }

      // for every item, get its images
      for (int i = 0; i < searchResult!.nasaMediaItems.length; i++) {
        NasaMediaItem item = searchResult!.nasaMediaItems.elementAt(i);
        List<String> links =
            await NetworkAPIRepository().getMediaLinks(item.href);
        searchResult!.nasaMediaItems.elementAt(i).setLinks(links);
      }

      setState(() {
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
        hasError = true;
      });
    }
  }
}
