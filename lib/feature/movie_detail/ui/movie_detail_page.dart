import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/feature/movie_detail/bloc/movie_detail_bloc.dart';
import 'package:movie_app/feature/movie_detail/ui/cast_widget.dart';
import 'package:movie_app/feature/movie_detail/ui/circle_vote_widget.dart';
import 'package:movie_app/data/models/movies_model.dart';

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
    return BlocBuilder(
        bloc: movieDetailBloc,
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
                //   elevation: 0,
                //   scrolledUnderElevation: 0,
                // ),
                body: SafeArea(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(alignment: Alignment.bottomCenter, children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.64,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  successState.movieDetail.fullPosterPath),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          height: 80,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.9),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleVoteAverageWidget(
                                  voteAverage:
                                      successState.movieDetail.voteAverage,
                                ),
                                Text(
                                  successState.movieDetail.releaseDate,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                      SizedBox(height: 16),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              successState.movieDetail.title,
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              successState.movieDetail.overview,
                              style: TextStyle(
                                fontSize: 16,
                                height: 1.4,
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              "Cast",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            CastWidget(
                              castList: successState.cast,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
              );
            default:
              return Container();
          }
        });
  }
}

    // return BlocConsumer<MovieDetailBloc, MovieDetailState>(
    //   bloc: movieDetailBloc,
    //   listener: (context, state) {},
    //   listenWhen: (previous, current) => current is MovieDetailActionState,
    //   buildWhen: (previous, current) => current is! MovieDetailActionState,
    //   builder: (context, state) {
    //     switch (state.runtimeType) {
    //       case MovieDetailLoadingState:
    //         return Scaffold(
    //           body: Center(
    //             child: CircularProgressIndicator(),
    //           ),
    //         );
    //       case MovieDetailErrorState:
    //         return Scaffold(
    //           body: Center(
    //             child: Text("Error"),
    //           ),
    //         );
    //       case MovieDetailLoadingSuccessState:
    //         var successState = (state as MovieDetailLoadingSuccessState);
    //         return Scaffold(
    //           appBar: AppBar(
    //             elevation: 0,
    //             scrolledUnderElevation: 0,
    //           ),
    //           body: SafeArea(
    //               child: SingleChildScrollView(
    //             child: Column(
    //               children: [
    //                 Stack(alignment: Alignment.bottomCenter, children: [
    //                   Container(
    //                     height: MediaQuery.of(context).size.height * 0.54,
    //                     foregroundDecoration: BoxDecoration(
    //                       // borderRadius: BorderRadius.circular(12),
    //                       gradient: LinearGradient(
    //                         begin: Alignment.topCenter,
    //                         end: Alignment.bottomCenter,
    //                         colors: [
    //                           Colors.transparent,
    //                           Colors.black.withOpacity(.82),
    //                         ],
    //                       ),
    //                     ),
    //                     decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(12),
    //                       image: DecorationImage(
    //                         image: NetworkImage(
    //                             "https://image.tmdb.org/t/p/w500${successState.movieDetail.fullPosterPath}"),
    //                         fit: BoxFit.cover,
    //                       ),
    //                     ),
    //                   ),
    //                   Container(
    //                     // width: 100,
    //                     width: 160,
    //                     decoration: BoxDecoration(
    //                         borderRadius: BorderRadius.circular(8),
    //                         color: Colors.red),
    //                     child: Padding(
    //                       padding: const EdgeInsets.all(4.0),
    //                       child: Row(
    //                           // mainAxisAlignment: MainAxisAlignment.center,
    //                           children: [
    //                             Icon(
    //                               Icons.play_arrow,
    //                               size: 28,
    //                             ),
    //                             Text(
    //                               "Watch Trailer",
    //                               style: TextStyle(
    //                                   fontWeight: FontWeight.bold,
    //                                   fontSize: 20),
    //                             )
    //                           ]),
    //                     ),
    //                   ),
    //                 ]),
    //                 SizedBox(height: 4),
    //                 Container(
    //                     child: Padding(
    //                   padding: const EdgeInsets.all(12.0),
    //                   child: Column(
    //                       mainAxisAlignment: MainAxisAlignment.start,
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Container(
    //                           child: Row(
    //                             mainAxisAlignment:
    //                                 MainAxisAlignment.spaceBetween,
    //                             children: [
    //                               Expanded(
    //                                 child: Text(
    //                                   successState.movieDetail.title,
    //                                   style: TextStyle(
    //                                     fontSize: 28,
    //                                     fontWeight: FontWeight.bold,
    //                                   ),
    //                                 ),
    //                               ),
    //                               CircleVoteAverage(
    //                                 voteAverage:
    //                                     successState.movieDetail.voteAverage,
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                         SizedBox(height: 12),
    //                         Container(
    //                           child: Text(
    //                             successState.movieDetail.releaseDate,
    //                             style: TextStyle(
    //                               color: Colors.white60,
    //                               fontSize: 18,
    //                               fontWeight: FontWeight.w500,
    //                             ),
    //                           ),
    //                         ),
    //                         SizedBox(height: 20),
    //                         Container(
    //                           child: Text(
    //                             successState.movieDetail.overview,
    //                             style: TextStyle(
    //                                 height: 1.4,
    //                                 color: Colors.white70,
    //                                 fontSize: 18,
    //                                 fontWeight: FontWeight.w500),
    //                           ),
    //                         ),
    //                         SizedBox(height: 20),
    //                         Text(
    //                           "Cast",
    //                           style: TextStyle(
    //                             fontSize: 24,
    //                             fontWeight: FontWeight.bold,
    //                           ),
    //                         ),
    //                         SizedBox(height: 12),
    //                         CastWidget(castList: successState.cast),
    //                         SizedBox(height: 4),
    //                         Text(
    //                           "Trailer",
    //                           style: TextStyle(
    //                             fontSize: 24,
    //                             fontWeight: FontWeight.bold,
    //                           ),
    //                         ),
    //                         SizedBox(height: 12),
    //                         // WatchTrailerWidget(
    //                         //     videoId: successState.video[0].key!),
    //                       ]),
    //                 ))
    //               ],
    //             ),
    //           )),
    //         );
    //       default:
    //         return Container();
    //     }
    //   },
    // );
//   }
// }
