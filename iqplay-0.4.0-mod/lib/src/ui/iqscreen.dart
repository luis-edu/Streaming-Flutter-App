import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import '../blocs/player/bloc.dart';
import '../blocs/screen/screen_bloc.dart';
import '../blocs/subtitle/bloc.dart';
import '../utils/iqtheme.dart';
import '../utils/subtitle_provider.dart';
import 'screen_controllers.dart';

/// UI Screen provide an awesome video player as a screen.
class IQScreen extends StatefulWidget {
  /// Provide a title of video on screen.
  final String title;

  /// Provide a description of video on screen.
  final String description;

  /// Controls a platform video player, and provides updates when the state is changing.
  final VideoPlayerController videoPlayerController;

  /// Provide a subtitle to display it.
  final SubtitleProvider subtitleProvider;

  /// You make your customization on theme.
  final IQTheme iqTheme;

  const IQScreen({
    Key key,
    @required this.title,
    @required this.videoPlayerController,
    this.iqTheme: const IQTheme(),
    this.description: '',
    this.subtitleProvider,
  })  : assert(title != null),
        assert(videoPlayerController != null),
        super(key: key);

  @override
  _IQScreenState createState() => _IQScreenState();
}

class _IQScreenState extends State<IQScreen>
    with SingleTickerProviderStateMixin {
  AnimationController playAnimationController;

  String get title => widget.title;

  String get description => widget.description;

  VideoPlayerController get videoPlayerController =>
      widget.videoPlayerController;

  SubtitleProvider get subtitleProvider => widget.subtitleProvider;

  IQTheme get iqTheme => widget.iqTheme;

  @override
  void initState() {
    playAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    videoPlayerController.initialize();
    videoPlayerController.play();
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    playAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: RotatedBox(
              quarterTurns: 0,
              child: VideoPlayer(
                videoPlayerController,
              ),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: MultiBlocProvider(
              providers: [
                BlocProvider<ScreenBloc>(
                  create: (context) => ScreenBloc(
                    title: title,
                    description: description,
                  ),
                ),
                BlocProvider<PlayerBloc>(
                  create: (context) =>
                      PlayerBloc(videoPlayerController)..add(FetchData()),
                ),
                if (widget.subtitleProvider != null)
                  BlocProvider<SubtitleBloc>(
                    create: (context) =>
                        SubtitleBloc(subtitleProvider)..add(FetchSubtitles()),
                  ),
              ],
              child: ScreenControllers(
                iqTheme: iqTheme,
                playAnimationController: playAnimationController,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
