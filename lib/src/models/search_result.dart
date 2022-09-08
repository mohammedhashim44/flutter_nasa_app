class SearchResult {
  late List<NasaMediaItem> nasaMediaItems;

  SearchResult(this.nasaMediaItems);

  SearchResult.fromJson(Map<String, dynamic> json) {
    json = json['collection'];

    nasaMediaItems = [];
    if (json["items"] != null) {
      json["items"].forEach((v) {
        String href = v["href"];

        if (v["data"] != null) {
          v["data"][0]["href"] = href;
          NasaMediaItem nasaMediaItem = NasaMediaItem.fromJson(v["data"][0]);
          nasaMediaItems.add(nasaMediaItem);
        }
      });
    }
  }
}

class NasaMediaItem {
  late String nasaId;
  late String title;
  late String href;
  late List<String> keywords;

  String? center;
  String? location;
  String? mediaType;
  String? dateCreated;
  String? description;

  List<String> links = [];

  NasaMediaItem(
    this.nasaId,
    this.center,
    this.title,
    this.location,
    this.mediaType,
    this.keywords,
    this.dateCreated,
    this.description,
  );

  NasaMediaItem.fromJson(Map<String, dynamic> json) {
    nasaId = json['nasa_id'];
    title = json['title'];
    href = json['href'];

    center = json['center'] ?? "";
    location = json['location'] ?? "";
    mediaType = json['media_type'];
    keywords = json['keywords'] != null ? json["keywords"].cast<String>() : [];
    dateCreated = json['date_created'] ?? "";
    description = json['description'] ?? "";
  }

  void setLinks(List<String> links) {
    this.links = links;
  }

  bool hasThumbnails() {
    for (var element in links) {
      if (element.contains("thumb.jpg")) {
        return true;
      }
    }
    return false;
  }

  String? getThumbnail() {
    for (var element in links) {
      if (element.contains("thumb.jpg")) {
        return element;
      }
    }
    return null;
  }

  bool isVideo() {
    return getLargestImage() == null;
  }

  String? getLargestImage() {
    String? large;
    String? medium;
    String? small;
    String? thumb;
    for (var element in links) {
      if (element.contains("large.jpg")) {
        large = element;
      }
      if (element.contains("medium.jpg")) {
        medium = element;
      }
      if (element.contains("small.jpg")) {
        small = element;
      }
      if (element.contains("thumb.jpg")) {
        thumb = element;
      }
    }

    if (large != null) {
      return large;
    }
    if (medium != null) {
      return medium;
    }
    if (small != null) {
      return small;
    }
    if (thumb != null) {
      return thumb;
    }
    return null;
  }
}
