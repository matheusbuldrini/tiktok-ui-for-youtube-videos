// To parse this JSON data, do
//
//     final video = videoFromJson(jsonString);

import 'dart:convert';

Video videoFromJson(String str) => Video.fromJson(json.decode(str));

String videoToJson(Video data) => json.encode(data.toJson());

Map<String, dynamic> allVideosFromJson(String str) {
  //print(str.length);
  final jsonData = json.decode(str);
  //print(jsonData['items'][8]['id'].toString());
  var list = List<Video>.from(jsonData['items'].map((x) => Video.fromJson(x)));
  var nextPageToken = jsonData['nextPageToken'];
  print(list.toString() + " " + nextPageToken);
  return {"list": list, "nextPageToken": nextPageToken};
}

class Video {
  Video({
    //this.kind,
    //this.etag,
    this.id,
    this.snippet,
  });

  //String kind;
  //String etag;
  String id;
  Snippet snippet;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        //kind: json["kind"],
        //etag: json["etag"],
        id: json["id"],
        snippet: Snippet.fromJson(json["snippet"]),
      );

  Map<String, dynamic> toJson() => {
        //"kind": kind,
        //"etag": etag,
        "id": id,
        "snippet": snippet.toJson(),
      };
}

class Snippet {
  Snippet({
    this.publishedAt,
    this.channelId,
    this.title,
    this.description,
    this.thumbnails,
    this.channelTitle,
    //this.tags,
    //this.categoryId,
    //this.liveBroadcastContent,
    //this.localized,
    //this.defaultAudioLanguage,
  });

  DateTime publishedAt;
  String channelId;
  String title;
  String description;
  Thumbnails thumbnails;
  String channelTitle;
  //List<String> tags;
  //String categoryId;
  //String liveBroadcastContent;
  //Localized localized;
  //String defaultAudioLanguage;

  factory Snippet.fromJson(Map<String, dynamic> json) => Snippet(
        publishedAt: DateTime.parse(json["publishedAt"]),
        channelId: json["channelId"],
        title: json["title"],
        description: json["description"],
        thumbnails: Thumbnails.fromJson(json["thumbnails"]),
        channelTitle: json["channelTitle"],
        //tags: List<String>.from(json["tags"].map((x) => x)),
        //categoryId: json["categoryId"],
        //liveBroadcastContent: json["liveBroadcastContent"],
        //localized: Localized.fromJson(json["localized"]),
        //defaultAudioLanguage: json["defaultAudioLanguage"],
      );

  Map<String, dynamic> toJson() => {
        "publishedAt": publishedAt.toIso8601String(),
        "channelId": channelId,
        "title": title,
        "description": description,
        "thumbnails": thumbnails.toJson(),
        "channelTitle": channelTitle,
        //"tags": List<dynamic>.from(tags.map((x) => x)),
        //"categoryId": categoryId,
        //"liveBroadcastContent": liveBroadcastContent,
        //"localized": localized.toJson(),
        //"defaultAudioLanguage": defaultAudioLanguage,
      };
}

/*class Localized {
  Localized({
    this.title,
    this.description,
  });

  String title;
  String description;

  factory Localized.fromJson(Map<String, dynamic> json) => Localized(
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
      };
}*/

class Thumbnails {
  Thumbnails({
    this.thumbnailsDefault,
    //this.medium,
    //this.high,
    //this.standard,
    //this.maxres,
  });

  Default thumbnailsDefault;
  //Default medium;
  //Default high;
  //Default standard;
  //Default maxres;

  factory Thumbnails.fromJson(Map<String, dynamic> json) => Thumbnails(
        thumbnailsDefault: Default.fromJson(json["default"]),
        //medium: Default.fromJson(json["medium"]),
        //high: Default.fromJson(json["high"]),
        //standard: Default.fromJson(json["standard"]),
        //maxres: Default.fromJson(json["maxres"]),
      );

  Map<String, dynamic> toJson() => {
        "default": thumbnailsDefault.toJson(),
        //"medium": medium.toJson(),
        //"high": high.toJson(),
        //"standard": standard.toJson(),
        //"maxres": maxres.toJson(),
      };
}

class Default {
  Default({
    this.url,
    this.width,
    this.height,
  });

  String url;
  int width;
  int height;

  factory Default.fromJson(Map<String, dynamic> json) => Default(
        url: json["url"],
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "width": width,
        "height": height,
      };
}
