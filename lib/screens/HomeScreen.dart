import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turnipoff/blocs/MoviePreview/MoviePreview.dart';
import 'package:turnipoff/models/MoviePreviewData.dart';
import 'package:turnipoff/widgets/CustomLoader.dart';
import 'package:turnipoff/widgets/PosterImage.dart';

import '../constants/route_constant.dart';
import '../main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _getRows(),
          )
        ],
      ),
    );
  }

  List<Widget> _getRows() {
    return [
      getTrendingMovies(),
      _getSeparator("Worst action movies"),
      getMovies(PreviewType.ACTION),
      _getSeparator("Worst 90's movies"),
      getMovies(PreviewType.NINETEES),
      _getSeparator("Worst 80's movies"),
      getMovies(PreviewType.EIGHTYS),
      _getSeparator("Worst comedy movies"),
      getMovies(PreviewType.COMEDY),
    ];
  }

  Widget getTrendingMovies() {
    final PageController controller = PageController();
    return SizedBox(
      height: 200,
      child: BlocProvider(
        create: (context) => MoviePreviewBloc()
          ..add(MoviePreviewFetched(type: PreviewType.CUSTOM_TRENDS)),
        child: BlocBuilder<MoviePreviewBloc, MoviePreviewState>(
          builder: (context, state) {
            return (state.status == MoviePreviewStatus.success)
                ? PageView(
                    controller: controller,
                    children: _trends(state),
                  )
                : CustomLoader(
                    color: Theme.of(context).colorScheme.secondary, size: 40);
          },
        ),
      ),
    );
  }

  List<Center> _trends(MoviePreviewState state) {
    return state.results
            .sublist(0, 7)
            .toList()
            .map((movie) => Center(
                    child: GestureDetector(
                  onTap: () {
                    navigatorKey.currentState
                        ?.pushNamed(moviePath, arguments: movie.id.toString());
                  },
                  child: PosterImage(
                      url: movie.posterPath, height: 198, width: 132),
                )))
            .toList();
  }

  Widget getMovies(PreviewType type) {
    return SizedBox(
      height: 120,
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
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: GestureDetector(
          onTap: () {
            navigatorKey.currentState
                ?.pushNamed(moviePath, arguments: movie.id.toString());
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: PosterImage(url: movie.posterPath),
          ),
        ));
  }

  Widget _getSeparator(String title) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(children: [
      const SizedBox(
        height: 16,
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 1,
        child:
            const DecoratedBox(decoration: BoxDecoration(color: Colors.white)),
      ),
      const SizedBox(
        height: 16,
      ),
      Padding(
        padding: const EdgeInsets.all(4),
        child: Text(
          title,
          style: textTheme.displayMedium,
        ),
      )
    ]);
  }
}
