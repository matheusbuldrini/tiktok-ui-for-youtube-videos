import 'package:flutter/material.dart';
import 'package:yt_tt2/models/video.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:cached_network_image/cached_network_image.dart';

const double ActionWidgetSize = 60.0;

// The size of the profile image in the follow Action
const double ProfileImageSize = 50.0;

Widget _getProfilePicture(String url) {
  return Positioned(
      left: (ActionWidgetSize / 2) - (ProfileImageSize / 2),
      child: Container(
          padding:
              EdgeInsets.all(1.0), // Add 1.0 point padding to create border
          height: ProfileImageSize, // ProfileImageSize = 50.0;
          width: ProfileImageSize, // ProfileImageSize = 50.0;
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(ProfileImageSize / 2)),
          // import 'package:cached_network_image/cached_network_image.dart'; at the top to use CachedNetworkImage
          child: CachedNetworkImage(
            imageUrl: url,
            placeholder: (context, url) => new CircularProgressIndicator(),
            errorWidget: (context, url, error) => new Icon(Icons.error),
          )));
}

Widget videoDescription(Video video) {
  return Expanded(
    child: Container(
      //color: Colors.blue,
      height: 75.0,
      //padding: EdgeInsets.only(left: 20.0),
      child: GestureDetector(
        // When the child is tapped, show a snackbar.
        onTap: () {
          print("channel details");
        },
        // The custom button
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: _getProfilePicture(
                  "https://secure.gravatar.com/avatar/ef4a9338dca42372f15427cdb4595ef7"),
            ),
            Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    video.snippet.channelTitle,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    timeago.format(video.snippet.publishedAt),
                  ),
                  /*Row(children: [
                  Icon(
                    Icons.music_note,
                    size: 15.0,
                    color: Colors.white,
                  ),
                  Text('Artist name - Album name - song',
                      style: TextStyle(fontSize: 12.0))
                ]),*/
                ]),
          ],
        ),
      ),
    ),
  );
}
