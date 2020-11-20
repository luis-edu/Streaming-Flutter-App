// import 'package:animaflix/CustomizedPlayer/CustomizedIQScreen.dart';
// import 'package:animaflix/Widgets/CustomIconButton.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:iqplayer/iqplayer.dart';
// import 'package:video_player/video_player.dart';

// class Details extends StatefulWidget {
//   final FirebaseFirestore firebase;
//   final String id;

//   const Details({Key key, @required this.firebase, @required this.id})
//       : super(key: key);
//   @override
//   _DetailsState createState() => _DetailsState();
// }

// class _DetailsState extends State<Details> {
//   List<dynamic> episodes = [
//     {'title': '', 'cover': '', 'description': ''}
//   ];
//   String title = '';
//   String cover = '';
//   String description = '';
//   @override
//   void initState() {
//     widget.firebase
//         .collection('anime')
//         .doc(widget.id)
//         .get()
//         .then((DocumentSnapshot snapshot) {
//       setState(() {
//         title = snapshot.get('title');
//         cover = snapshot.get('cover');
//         description = snapshot.get('description');
//         episodes = List.from(snapshot.get('episodes'));
//       });
//     });
//     super.initState();
//   }

//   Future<void> _showMyDialog(
//       VideoPlayerController controller, String title) async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: true, // user must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(title),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 // Player(
//                 //   videoPlayerController: controller,
//                 // )
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Fechar'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title ?? 'a'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//                 height: 270,
//                 color: Colors.blue[100],
//                 child: Row(
//                   children: [
//                     Image.network(cover ?? 'a'),
//                     Flexible(
//                       child: Text(description ?? ''),
//                     )
//                   ],
//                 )),
//             SizedBox(
//               height: 15,
//             ),
//             Text(
//               'EPISODIOS',
//               style: Theme.of(context).textTheme.headline5,
//             ),
//             for (var item in episodes)
//               ListTile(
//                   title: Text(item['name'] ?? 'a'),
//                   trailing: CustomIconButton(
//                     onPress: () {},
//                     icon: Icons.play_circle_outline,
//                     iconSize: 35,
//                     fillColor: Colors.green,
//                   ))
//           ],
//         ),
//       ),
//     );
//   }
// }
