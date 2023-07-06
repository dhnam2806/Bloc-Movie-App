import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class WatchTrailerWidget extends StatefulWidget {
  final String videoId;
  WatchTrailerWidget({required this.videoId});

  @override
  State<WatchTrailerWidget> createState() => _WatchTrailerWidgetState();
}

class _WatchTrailerWidgetState extends State<WatchTrailerWidget> {

  @override
  Widget build(BuildContext context) {
    YoutubePlayerController controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: YoutubePlayer(
        controller: controller,
        showVideoProgressIndicator: false,
      ),
    );
  }
}
