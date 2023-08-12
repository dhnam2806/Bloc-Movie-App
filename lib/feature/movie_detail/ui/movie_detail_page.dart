import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/data/models/video_model.dart';
import 'package:movie_app/feature/movie_detail/bloc/movie_detail_bloc.dart';
import 'package:movie_app/feature/movie_detail/ui/widget/button.dart';
import 'package:movie_app/feature/movie_detail/ui/widget/cast_widget.dart';
import 'package:movie_app/feature/movie_detail/ui/widget/circle_vote_widget.dart';
import 'package:movie_app/data/models/movies_model.dart';
import 'package:movie_app/feature/movie_detail/ui/widget/watch_trailer_widget.dart';

class MovieDetailPage extends StatefulWidget {
  final MovieModels movie;
  const MovieDetailPage({super.key, required this.movie});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  final VideoModel video = VideoModel();
  final MovieDetailBloc movieDetailBloc = MovieDetailBloc();

  @override
  void initState() {
    movieDetailBloc.add(MovieDetailInitialEvent(movie_id: widget.movie));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final safePadding = MediaQuery.of(context).padding.top;
    return BlocConsumer<MovieDetailBloc, MovieDetailState>(
      bloc: movieDetailBloc,
      listener: (context, state) {
        if (state is WatchTrailerNavigateState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      WatchTrailerWidget(videoId: state.videoId)));
        }
        if (state is AddToFavoriteListState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Added to favorite list'),
              duration: Duration(seconds: 1),
            ),
          );
        }
      },
      listenWhen: (previous, current) => current is MovieDetailActionState,
      buildWhen: (previous, current) => current is! MovieDetailActionState,
      builder: (context, state) {
        switch (state.runtimeType) {
          case MovieDetailLoadingState:
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case MovieDetailErrorState:
            return Scaffold(
              body: Center(
                child: Text("Error"),
              ),
            );
          case MovieDetailLoadingSuccessState:
            var successState = (state as MovieDetailLoadingSuccessState);
            return Scaffold(
              body: SingleChildScrollView(
                child: Stack(alignment: Alignment.topCenter, children: [
                  Column(
                    children: [
                      Stack(alignment: Alignment.bottomCenter, children: [
                        Container(
                          height: size.height * 0.65,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: NetworkImage(
                                  successState.movieDetail.fullPosterPath),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          height: 120,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.6),
                                Colors.black.withOpacity(1),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            movieDetailBloc.add(WatchTrailerNavigateEvent(
                                movie_id: successState.movieDetail));
                          },
                          child: Container(
                            width: 200,
                            height: 48,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.red),
                            child: Container(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.play_arrow,
                                      size: 28,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "Watch Trailer",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22),
                                    )
                                  ]),
                            ),
                          ),
                        ),
                      ]),
                      SizedBox(height: 4),
                      Container(
                          child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        successState.movieDetail.title,
                                        style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    CircleVoteAverageWidget(
                                      voteAverage:
                                          successState.movieDetail.voteAverage,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 12),
                              Container(
                                child: Text(
                                  successState.movieDetail.overview,
                                  style: TextStyle(
                                      height: 1.4,
                                      color: Colors.white70,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(height: 16),
                              Container(
                                child: Text(
                                  "Release Date: " +
                                      successState.movieDetail.releaseDate,
                                  style: TextStyle(
                                    color: Colors.white60,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                "Cast",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 16),
                              CastWidget(castList: successState.cast),
                            ]),
                      )),
                    ],
                  ),
                  Positioned(
                    top: safePadding + 4,
                    left: 4,
                    right: 4,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: ButtonCustom(
                              iconData: Icon(Icons.arrow_back_ios_new),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              movieDetailBloc.add(
                                  AddToFavoriteListEvent(movie: widget.movie));
                            },
                            child: ButtonCustom(
                              iconData: Icon(Icons.favorite_border),
                            ),
                          ),
                        ]),
                  ),
                ]),
              ),
            );
          default:
            return Container();
        }
      },
    );
  }
}
