import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class WatchTrailerWidget extends StatelessWidget {
  final String videoId;
  WatchTrailerWidget({required this.videoId});

  @override
  Widget build(BuildContext context) {
    YoutubePlayerController controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Trailer"),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: YoutubePlayer(
            controlsTimeOut: Duration(seconds: 1),
            controller: controller,
            showVideoProgressIndicator: false,
          ),
        ),
      ),
    );
  }
}
