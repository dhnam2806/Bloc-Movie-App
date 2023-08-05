import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/data/models/movies_model.dart';
import 'package:movie_app/feature/search/bloc/search_bloc.dart';
import '../../movie_detail/ui/movie_detail_page.dart';

class SearchPage extends StatefulWidget {
  SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchBloc searchBloc = SearchBloc();
  TextEditingController controller = TextEditingController();
  List<MovieModels> movieList = [];

  @override
  void initState() {
    searchBloc.add(SearchInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      bloc: searchBloc,
      listener: (context, state) {
        if (state is SearchMovieClickedState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MovieDetailPage(movie: state.movie)));
        }
      },
      listenWhen: (previous, current) => current is SearchActionState,
      buildWhen: (previous, current) => current is! SearchActionState,
      builder: (context, state) {
        switch (state.runtimeType) {
          case SearchLoadingState:
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case SearchErrorState:
            return Scaffold(
              body: Center(
                child: Text("Error"),
              ),
            );
          case SearchLoadingSuccessState:
            var successState = (state as SearchLoadingSuccessState);
            return Scaffold(
              body: SafeArea(
                child: Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            hintText: "Search",
                            prefixIcon: Icon(Icons.search),
                          ),
                          onChanged: (value) {
                            searchBloc.add(SearchQueryEvent(query: value));
                          },
                        ),
                      ),
                      SizedBox(height: 12),
                      Expanded(
                        child: ListView.builder(
                            itemCount: successState.movieList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    searchBloc.add(SearchMovieClickedEvent(
                                        movie: successState.movieList[index]));
                                  },
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          successState
                                              .movieList[index].posterPath342,
                                          width: 120,
                                        ),
                                      ),
                                      SizedBox(width: 12),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              successState
                                                  .movieList[index].title,
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              "Release Date: " +
                                                  successState.movieList[index]
                                                      .releaseDate,
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            );
          default:
            return Container();
        }
      },
    );
  }
}
