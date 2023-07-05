// ignore_for_file: public_member_api_docs, sort_constructors_first
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
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: true,
        showLiveFullscreenButton: false,
      ),
    );
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
      ),
    );
  }
}
