import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flick_video_player/flick_video_player.dart';

class NetworkVideoPlayerWidget extends StatefulWidget {
  final String url;

  const NetworkVideoPlayerWidget({Key? key, required this.url})
      : super(key: key);

  @override
  _NetworkVideoPlayerWidgetState createState() =>
      _NetworkVideoPlayerWidgetState();
}

class _NetworkVideoPlayerWidgetState extends State<NetworkVideoPlayerWidget> {
  late FlickManager flickManager;

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(
        // "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
        widget.url,
      ),
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16.0 / 9.0,
      child: FlickVideoPlayer(flickManager: flickManager),
    );
  }
}
