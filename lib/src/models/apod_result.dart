// APOD : Astronomy Picture Of The Day
class APODResult {
  late String date;
  late String explanation;
  late String mediaType;
  late String serviceVersion;
  late String title;
  late String url;
  late String? copyright;

  APODResult({
    required this.date,
    required this.explanation,
    required this.mediaType,
    required this.serviceVersion,
    required this.title,
    required this.url,
    this.copyright,
  });

  APODResult.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    explanation = json['explanation'];
    mediaType = json['media_type'];
    serviceVersion = json['service_version'];
    title = json['title'];
    url = json['url'];
    copyright = json['copyright'];
  }

  bool isVideo() {
    return mediaType == "video";
  }
}
