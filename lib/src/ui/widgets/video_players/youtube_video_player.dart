import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideoPlayerWidget extends StatefulWidget {
  final String url;

  const YoutubeVideoPlayerWidget({Key? key, required this.url})
      : super(key: key);

  @override
  _YoutubeVideoPlayerWidgetState createState() =>
      _YoutubeVideoPlayerWidgetState();
}

class _YoutubeVideoPlayerWidgetState extends State<YoutubeVideoPlayerWidget> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    // String videoUrl = "https://www.youtube.com/watch?v=dtT5798r3qs";
    String videoUrl = widget.url;
    String videoId = YoutubePlayer.convertUrlToId(videoUrl) ?? "";
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16.0 / 9.0,
      child: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
      ),
    );
  }
}
