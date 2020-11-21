import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:yt_tt2/models/video.dart';

//String url = 'https://youtube.googleapis.com/youtube/v3/search?part=id,snippet&q=viniccius&key=AIzaSyDfMIMsXiDbr5trTOuNMTda7npBojGtM7Y&type=video';
String url =
    'https://www.googleapis.com/youtube/v3/videos?part=id,snippet&chart=mostPopular&key=AIzaSyDfMIMsXiDbr5trTOuNMTda7npBojGtM7Y&regionCode=BR&maxResults=20&pageToken=';

Future<Map<String, dynamic>> getVideos(String pageToken) async {
  final response = await http.get(url + pageToken);
  //print(response.body.length);
  var allVideos = allVideosFromJson(response.body);
  //print(allVideos['list']);
  print("getVideos END");
  return {
    "videos": allVideos['list'],
    "nextPageToken": allVideos['nextPageToken']
  };
  /*return Future.delayed(
    Duration(seconds: 2),
    () => {
      "video": allVideos['list'][0],
      "nextPageToken": allVideos['nextPageToken']
    },
  );*/
}
/*
Future<Video> getVideo() async {
  final response = await http.get('$url');
  return videoFromJson(response.body);
}*/
