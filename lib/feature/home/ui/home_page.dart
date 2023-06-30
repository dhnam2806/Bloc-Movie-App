import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/feature/home/bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listener: (context, state) {},
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeErrorState:
            return Scaffold(
              body: Center(
                child: Text("Error"),
              ),
            );

          case HomeLoadingState:
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );

          case HomeLoadingSuccessState:
            final successState = state as HomeLoadingSuccessState;
            return Scaffold(
              appBar: AppBar(
                title: Text("Movie App"),
                centerTitle: true,
              ),
              body: ListView.builder(
                itemCount: successState.moviesModel.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 100,
                    child: Row(
                      children: [
                        Image.network(
                          "https://image.tmdb.org/t/p/w500${successState.moviesModel[index].posterPath}",
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                successState.moviesModel[index].title,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                successState.moviesModel[index].overview,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          default:
            return SizedBox();
        }
      },
    );
  }
}
