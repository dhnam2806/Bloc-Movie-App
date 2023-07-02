import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/feature/movie_detail/bloc/movie_detail_bloc.dart';
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
            var successState =
                (state as MovieDetailLoadingSuccessState).movieDetail;
            return Scaffold(
                appBar: AppBar(
                  title: Text("Movie Detail"),
                  centerTitle: false,
                ),
                body: SingleChildScrollView(
                  child: Container(
                    child: Column(children: [
                      Image.network(
                        'https://image.tmdb.org/t/p/w500/${successState.posterPath}',
                        height: 240,
                        width: 160,
                        fit: BoxFit.cover,
                      ),
                      Text(successState.title),
                      Text(successState.overview),
                    ]),
                  ),
                ));
          default:
            return Container();
        }
      },
    );
  }
}
