import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turnipoff/blocs/MoviePreview/MoviePreview.dart';
import 'package:turnipoff/models/MoviePreviewData.dart';
import 'package:turnipoff/widgets/CustomLoader.dart';
import 'package:turnipoff/widgets/Poster.dart';
import 'package:turnipoff/widgets/SeparatorWidget.dart';

import '../constants/route_constant.dart';
import '../main.dart';
import '../widgets/PosterCarousel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("TurnipOff Flutter"),
        ),
        body: ListView(children: [
          getTrendingMovies(),
          const SizedBox(
            height: 16,
          ),
          _getSeparator("Worst action movies"),
          getMovies(PreviewType.ACTION),
          const SizedBox(
            height: 8,
          ),
          _getSeparator("Worst 90's movies"),
          getMovies(PreviewType.NINETEES),
          _getSeparator("Worst 80's movies"),
          getMovies(PreviewType.EIGHTYS),
          _getSeparator("Worst comedy movies"),
          getMovies(PreviewType.COMEDY),
        ]));
  }

  Widget getTrendingMovies() {
    return BlocProvider(
      create: (context) => MoviePreviewBloc()
        ..add(const MoviePreviewFetched(type: PreviewType.CUSTOM_TRENDS)),
      child: BlocBuilder<MoviePreviewBloc, MoviePreviewState>(
        builder: (context, state) {
          return (state.status == MoviePreviewStatus.success)
              ? PosterCarousel(
                  movies: state.results,
                  onMovieClicked: (id) => {
                    navigatorKey.currentState
                        ?.pushNamed(moviePath, arguments: id)
                  },
                )
              : CustomLoader(
                  color: Theme.of(context).colorScheme.primary, size: 40);
        },
      ),
    );
  }

  Widget getMovies(PreviewType type) {
    return SizedBox(
      height: 215,
      child: BlocProvider(
        create: (context) =>
            MoviePreviewBloc()..add(MoviePreviewFetched(type: type)),
        child: BlocBuilder<MoviePreviewBloc, MoviePreviewState>(
          builder: (context, state) {
            switch (state.status) {
              case MoviePreviewStatus.success:
                if (state.results.isEmpty) {
                  return const Center(child: Text('no movie'));
                }
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    if (index >= state.results.length) {
                      BlocProvider.of<MoviePreviewBloc>(context)
                          .add(MoviePreviewFetched(type: type));
                    }
                    return index >= state.results.length
                        ? const Center(child: CircularProgressIndicator())
                        : buildListItem(state.results[index]);
                  },
                  itemCount: state.hasReachedMax
                      ? state.results.length
                      : state.results.length + 1,
                );
              case MoviePreviewStatus.failure:
                return const Center(child: Text('failed to fetch movies'));
              default:
                return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget buildListItem(Results movie) {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: GestureDetector(
          onTap: () {
            navigatorKey.currentState
                ?.pushNamed(moviePath, arguments: movie.id.toString());
          },
          child: Poster(
              url: movie.posterPath,
              format: PosterFormat.w154,
              height: MediaQuery.of(context).size.height / 5),
        ));
  }

  Widget _getSeparator(String title) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(children: [
      SeparatorWidget(context: context),
      const SizedBox(
        height: 12,
      ),
      Text(
        title,
        style: textTheme.titleMedium,
      )
    ]);
  }
}
