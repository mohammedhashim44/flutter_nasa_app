class EPICResult {
  late final List<EPICItem> epicItems;

  EPICResult.fromJson(dynamic json) {
    epicItems = <EPICItem>[];
    json.forEach((element) {
      EPICItem epicItem = EPICItem.fromJson(element);
      epicItems.add(epicItem);
    });
  }
}

class EPICItem {
  late String identifier;
  late String image;
  late String date;

  late String thumbnailUrl;
  late String imageUrl;

  EPICItem.fromJson(Map<String, dynamic> json) {
    identifier = json['identifier'];
    image = json['image'];
    date = json['date'];

    constructItemAssetLinks();
  }

  void constructItemAssetLinks() {
    String epicImageAssetPath =
        "https://epic.gsfc.nasa.gov/archive/natural/YEAR/MONTH/DAY/EXT/IMAGE_FILE.EXT";

    DateTime dateTime = DateTime.parse(date);
    String year = dateTime.year.toString();
    String month = dateTime.month.toString().padLeft(2, "0");
    String day = dateTime.day.toString().padLeft(2, "0");

    epicImageAssetPath = epicImageAssetPath
        .replaceAll("YEAR", year)
        .replaceAll("MONTH", month)
        .replaceAll("DAY", day)
        .replaceAll("IMAGE_FILE", image);

    thumbnailUrl = epicImageAssetPath.replaceAll("EXT", "jpg");
    imageUrl = epicImageAssetPath.replaceAll("EXT", "png");
  }
}
