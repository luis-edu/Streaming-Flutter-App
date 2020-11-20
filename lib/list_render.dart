import 'package:animaflix/Widgets/CustomIconButton.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:video_player/video_player.dart';
import 'package:iqplayer/iqplayer.dart';

class AnimesRender extends StatelessWidget {
  final FirebaseFirestore firebase;

  const AnimesRender({Key key, @required this.firebase}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference animes = firebase.collection('anime');

    return Scaffold(
      appBar: AppBar(
        title: Text('Animes'),
        actions: [
          FlatButton(
            child: Icon(Icons.search_off),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: animes.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            return new GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 6,
              mainAxisSpacing: 6,
              childAspectRatio: 100 / 150,
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                return new GridTile(
                  footer: new Container(
                    height: 80,
                    color: Colors.black38,
                    child: Text(
                      document.data()['title'],
                      style: TextStyle(color: Colors.white, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      firebase
                          .collection('anime')
                          .doc(document.id)
                          .get()
                          .then((DocumentSnapshot snapshot) {
                        List<dynamic> episodes = [
                          {'title': '', 'cover': '', 'description': ''}
                        ];

                        episodes = List.from(snapshot.get('episodes'));

                        showBottomSheet(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(30.0),
                                  topRight: const Radius.circular(30.0)),
                            ),
                            backgroundColor: Colors.brown[200],
                            context: context,
                            builder: (builder) {
                              return Container(
                                  height: 500,
                                  decoration: new BoxDecoration(
                                      borderRadius: BorderRadius.only()),
                                  width: double.infinity,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        CustomIconButton(
                                            iconSize: 40,
                                            onPress: () {
                                              Navigator.pop(context);
                                            }),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(30),
                                              child: Container(
                                                width: 150,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  child: CachedNetworkImage(
                                                      imageUrl: snapshot
                                                          .get('cover')),
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                              child: Text(
                                                  'Ddsakladsj daslkdsjal adsjlkadsj jadslkdasj jadslkdasj ajsdlkdasj djaskldasjlk'),
                                            )
                                          ],
                                        ),
                                        Text(
                                          'Episodios',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        for (var x in episodes)
                                          Column(
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              ListTile(
                                                  title: Text(x['name']),
                                                  trailing: CustomIconButton(
                                                      icon: Icons
                                                          .play_circle_filled,
                                                      iconSize: 38,
                                                      fillColor: Colors
                                                          .deepOrange[200],
                                                      onPress: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                IQScreen(
                                                              title: 'AAA',
                                                              description:
                                                                  'Simple video as a demo video',
                                                              videoPlayerController:
                                                                  VideoPlayerController
                                                                      .network(
                                                                'https://d11b76aq44vj33.cloudfront.net/media/720/video/5def7824adbbc.mp4',
                                                              ),
                                                              iqTheme: IQTheme(
                                                                loadingProgress:
                                                                    SpinKitCircle(
                                                                  color: Colors
                                                                      .red,
                                                                ),
                                                                playButtonColor:
                                                                    Colors
                                                                        .transparent,
                                                                videoPlayedColor:
                                                                    Colors
                                                                        .indigo,
                                                                playButton: (BuildContext
                                                                        context,
                                                                    bool isPlay,
                                                                    AnimationController
                                                                        animationController) {
                                                                  if (isPlay)
                                                                    return Icon(
                                                                      Icons
                                                                          .pause_circle_filled,
                                                                      color: Colors
                                                                          .red,
                                                                      size: 50,
                                                                    );
                                                                  return Icon(
                                                                    Icons
                                                                        .play_circle_outline,
                                                                    color: Colors
                                                                        .red,
                                                                    size: 50,
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      })),
                                              Divider(
                                                height: 2,
                                              )
                                            ],
                                          )
                                        // for (var x in episodes)
                                        //   GridTile(
                                        //     header: Text(x['name'] ?? 'a'),
                                        //     footer: IconButton(
                                        //       icon: Icon(Icons.play_arrow),
                                        //       onPressed: () {
                                        //         _showMyDialog(
                                        //             new VideoPlayerController
                                        //                 .network(x['url']),
                                        //             x['name']);
                                        //       },
                                        //     ),
                                        //     child: Container(
                                        //         child: Text('Hell No')),
                                        //   )
                                      ],
                                    ),
                                  ));
                            });
                      });
                    },
                    child: Container(
                      child: CachedNetworkImage(
                        placeholder: (context, url) =>
                            CircularProgressIndicator(
                          value: 50,
                        ),
                        imageUrl: document.data()['cover'],
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
