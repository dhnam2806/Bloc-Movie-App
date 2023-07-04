import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/feature/movie_detail/bloc/movie_detail_bloc.dart';
import 'package:movie_app/feature/movie_detail/ui/cast_widget.dart';
import 'package:movie_app/feature/movie_detail/ui/circle_vote_widget.dart';
import 'package:movie_app/feature/movies/models/movies_model.dart';

class MovieDetailPage extends StatefulWidget {
  final MovieModels movie;
  const MovieDetailPage({super.key, required this.movie});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  final MovieDetailBloc movieDetailBloc = MovieDetailBloc();

  @override
  void initState() {
    movieDetailBloc.add(MovieDetailInitialEvent(movie_id: widget.movie));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MovieDetailBloc, MovieDetailState>(
      bloc: movieDetailBloc,
      listener: (context, state) {},
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
              // appBar: AppBar(
              //   title: Text("Movie Detail"),
              //   centerTitle: false,
              // ),
              body: SafeArea(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.52,
                      foregroundDecoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.8),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://image.tmdb.org/t/p/w500${successState.movieDetail.fullPosterPath}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
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
                                  CircleVoteAverage(
                                    voteAverage:
                                        successState.movieDetail.voteAverage,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16),
                            Container(
                              child: Text(
                                successState.movieDetail.releaseDate,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
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
                            SizedBox(height: 20),
                            Text(
                              "Cast",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 12),
                            CastWidget(castList: successState.cast)
                          ]),
                    ))
                  ],
                ),
              )),
            );
          default:
            return Container();
        }
      },
    );
  }
}
