import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../movie_detail/ui/movie_detail_page.dart';
import '../bloc/favorite_bloc.dart';

class FavoriteMoviesScreen extends StatefulWidget {
  @override
  State<FavoriteMoviesScreen> createState() => _FavoriteMoviesScreenState();
}

class _FavoriteMoviesScreenState extends State<FavoriteMoviesScreen> {
  final favoriteBloc = FavoriteBloc();

  @override
  void initState() {
    favoriteBloc.add(FavoriteMoviesInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<FavoriteBloc, FavoriteState>(
        bloc: favoriteBloc,
        listener: (context, state) {
          if (state is FavoriteMovieRemoveMovieState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Movie removed from favorite'),
                duration: Duration(seconds: 1),
              ),
            );
          }
          if (state is FavoriteMovieClickedState) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MovieDetailPage(movie: state.movie)));
          }
        },
        listenWhen: (previous, current) => current is FavoriteActionState,
        buildWhen: (previous, current) => current is! FavoriteActionState,
        builder: (context, state) {
          if (state is FavoriteMoviesLoading) {
            return Center(
                child: CircularProgressIndicator(
              color: Colors.red,
            ));
          } else if (state is FavoriteMoviesErrorState) {
            return Center(child: Text(state.message));
          } else if (state is FavoriteMoviesLoadedState) {
            final favoriteMovies = state.movies;
            return ListView.builder(
              itemCount: favoriteMovies.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    favoriteBloc.add(
                      FavoriteMovieClickedEvent(
                        movie: favoriteMovies[index],
                      ),
                    );
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: Slidable(
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              favoriteBloc.add(
                                FavoriteRemoveMovieEvent(
                                  movie: favoriteMovies[index],
                                ),
                              );
                            },
                            icon: Icons.delete,
                            foregroundColor: Colors.red,
                            label: 'Delete',
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              favoriteMovies[index].posterPath342,
                              width: 120,
                            ),
                          ),
                          SizedBox(width: 8),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  favoriteMovies[index].title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  favoriteMovies[index].overview,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 4,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 12),
                          GestureDetector(
                              onTap: () {
                                favoriteBloc.add(
                                  FavoriteRemoveMovieEvent(
                                    movie: favoriteMovies[index],
                                  ),
                                );
                              },
                              child: Icon(Icons.delete, color: Colors.red)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
