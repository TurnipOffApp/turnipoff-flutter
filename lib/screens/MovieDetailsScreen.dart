import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turnipoff/blocs/MoviePreview/MoviePreview.dart';
import 'package:turnipoff/models/MoviePreviewData.dart';

import '../blocs/Movie/Movie_bloc.dart';
import '../blocs/Movie/Movie_event.dart';
import '../blocs/Movie/Movie_state.dart';
import '../constants/network_constants.dart';
import '../repositories/MovieRepositories.dart';
import '../widgets/CustomLoader.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  final Map<int, List<Results>> movies = {};

  @override
  void initState() {
    super.initState();
    for (var element in PreviewType.values) {
      movies.putIfAbsent(element.index, () => []);
    }
  }

  @override
  Widget build(BuildContext context) {
    final MovieRepositoryImpl _repo = MovieRepositoryImpl();
    return SafeArea(
      child: BlocProvider(
        create: (context) => MovieBloc(_repo)..add(LoadMovie(id: widget.id)),
        child: BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            return (state is MovieLoaded)
                ? buildColumn(state)
                : CustomLoader(
                    color: Theme.of(context).colorScheme.secondary, size: 40);
          },
        ),
      ),
    );
  }

  Column buildColumn(MovieLoaded state) {
    return Column(
      children: [
        buildTopScreenImg(state),
        buildSeparator(),
        buildMovieInfo(state),
        buildSeparator(),
        buildSynopsys(state),
        buildSeparator(),
        buildCast(state),
        buildCrew(state)
      ],
    );
  }

  Widget buildSeparator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 1,
        child:
            const DecoratedBox(decoration: BoxDecoration(color: Colors.white)),
      ),
    );
  }

  Stack buildTopScreenImg(MovieLoaded state) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [backdropImg(state), posterImg(state)],
    );
  }

  Widget backdropImg(MovieLoaded state) {
    return state.data?.backdropPath != null
        ? ClipRRect(
            child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
                child: FadeInImage.assetNetwork(
                    height: 200,
                    placeholder: 'assets/images/img_placeholder.png',
                    image: NetworkConstants.LARGE_IMAGE_URL +
                        (state.data!.backdropPath!))),
          )
        : Image.asset(
            'assets/images/img_placeholder.png',
          );
  }

  Widget posterImg(MovieLoaded state) {
    return state.data?.posterPath != null
        ? Padding(
            padding: const EdgeInsets.all(16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/images/img_placeholder.png',
                image:
                    NetworkConstants.BASE_IMAGE_URL + (state.data!.posterPath!),
                height: 132,
                width: 88,
              ),
            ),
          )
        : Image.asset(
            'assets/images/img_placeholder.png',
            height: 132,
            width: 88,
          );
  }

  Widget buildMovieInfo(MovieLoaded state) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blueGrey,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  state.data?.voteAverage?.toString() ?? "",
                  style: textTheme.displayMedium,
                ),
              )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                state.data?.title ?? "",
                style: textTheme.displayMedium,
              ),
              Text(
                (state.data?.releaseDate ?? "") +
                    " " +
                    (state.data?.productionCountries?.first.name ?? ""),
                style: textTheme.displaySmall,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildSynopsys(MovieLoaded state) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Text(
        state.data?.overview ?? "Missing overview",
        style: Theme.of(context).textTheme.displaySmall,
      ),
    );
  }

  Widget buildCast(MovieLoaded state) {
    return Column(
      children: const [
        Text(
          "Cast",
          style: TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget buildCrew(MovieLoaded state) {
    return Container();
  }
}
