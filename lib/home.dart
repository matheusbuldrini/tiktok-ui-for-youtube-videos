import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:yt_tt2/models/video.dart';

import 'package:yt_tt2/services/youtube_videos.dart';

import 'package:yt_tt2/widgets/video_description.dart';
import 'package:yt_tt2/widgets/actions_toolbar.dart';
import 'package:yt_tt2/widgets/bottom_toolbar.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:yt_tt2/screens/profile.dart';

Widget get topSection => Container(
      height: 100.0,
      padding: EdgeInsets.only(bottom: 15.0),
      alignment: Alignment(0.0, 1.0),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Recomendados'),
            Container(
              width: 15.0,
            ),
            Text('Em alta',
                style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold))
          ]),
    );

Widget middleSection(Video video) {
  return Expanded(
      child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[videoDescription(video), ActionsToolbar()]));
}

Widget _listItemBuilder(Video video) {
  //print(vidList[0].snippet.title);

  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: video.id,
    flags: YoutubePlayerFlags(
      autoPlay: true,
      mute: false,
      loop: true,
      hideControls: true,
      controlsVisibleAtStart: false,
      enableCaption: false,
      hideThumbnail: false,
      forceHD: true,
    ),
  );

  return YoutubePlayerBuilder(
      player: YoutubePlayer(
        //width: height * 16 / 9,
        bottomActions: [],
        topActions: [],
        controller: _controller,
      ),
      builder: (context, player) {
        return Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            GestureDetector(
                onTap: () {
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                  } else {
                    _controller.play();
                  }
                },
                onDoubleTap: () {
                  _controller.reload();
                },
                child: SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: player,
                  ),
                )),
            Container(
                //alignment: Alignment.bottomLeft,
                child: Column(
              children: <Widget>[
                // Top section
                //topSection,

                // Middle expanded
                middleSection(video),

                // Bottom Section
                //Container(width: 45.0, height: 35.0)
              ],
            )),
          ],
        );
      });
}

//int _upperCount = 1;
String nextPageToken = "";
//List<String> requestedPages = [];

/*Future<Widget> newPage() async {
  print(nextPageToken);

  return FutureBuilder<Map<String, dynamic>>(
      future: getVideo(nextPageToken),
      initialData: {'video': null, "nextPageToken": ""},
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          print(snapshot.data['nextPageToken']);

          nextPageToken = snapshot.data['nextPageToken'];

          return _listItemBuilder(snapshot.data['video'].id);
          //return Text(snapshot.data['video'].id + " page: " + nextPageToken);
        } else {
          return Text("loading ...");
        }
      });
}
*/
class MainPage extends StatefulWidget {
  final User loggedUser;
  MainPage({Key key, @required this.loggedUser}) : super(key: key);
  @override
  MainPageState createState() {
    return new MainPageState();
  }
}

class MainPageState extends State<MainPage> {
  @override
  void initState() {
    /*addPages().then((value) {
      print("async done");
    });*/
    super.initState();
  }

  /*Future<void> addPage() async {
    /*if (requestedPages.contains(nextPageToken)) {
      //  requestedPages.clear();

      return;
    } else {
      requestedPages.add(nextPageToken);
    }*/

    await newPage().then((page) {
      _pages.add(page);
    });
  }
*/
  List<Widget> _pages = <Widget>[];

  Future<List<Widget>> addPages() async {
    var response = await getVideos(nextPageToken);
    for (Video video in response['videos']) {
      print(video.id);
      var page = _listItemBuilder(video);
      _pages.add(page);
    }
    nextPageToken = response['nextPageToken'];
    return _pages;
  }

  @override
  Widget build(BuildContext context) {
    //final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('My App'),
        backgroundColor: Theme.of(context).primaryColor,
        actions: <Widget>[
          IconButton(
            /*icon: Icon(
              Icons.account_circle_outlined,
              color: Colors.white,
            ),*/
            icon: CircleAvatar(
              backgroundImage: NetworkImage(widget.loggedUser
                  .photoURL), //"https://secure.gravatar.com/avatar/ef4a9338dca42372f15427cdb4595ef7"),
              //child: Text("MB"),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile()),
              );
            },
          )
        ],
      ),
      /*appBar: PreferredSize(
        preferredSize: Size(double.infinity, 100),
        child: topSection,
      ),*/
      extendBody: false,
      extendBodyBehindAppBar: false,
      body: FutureBuilder<List<Widget>>(
          future: addPages(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              return PageView(
                scrollDirection: Axis.vertical,
                onPageChanged: (pageId) async {
                  if (pageId == _pages.length - 10) {
                    print("Almost Last page, add page to end");
                    //_upperCount = _upperCount + 1;
                    await addPages();
                    //_pages.add(newPage());

                  }
                },
                controller: PageController(
                  initialPage: 0,
                ),
                children: _pages,
              );
            } else {
              return Text('loading pageview');
            }
          }),

      /*PageView(
        scrollDirection: Axis.vertical,
        onPageChanged: (pageId) async {
          if (pageId == _pages.length - 1) {
            print("Last page, add page to end");
            //_upperCount = _upperCount + 1;
            await addPages();
            //_pages.add(newPage());

          }
        },
        controller: PageController(
          initialPage: 0,
        ),
        children: _pages,
      ),*/

      bottomNavigationBar: BottomToolbar(),
    );
  }
}
