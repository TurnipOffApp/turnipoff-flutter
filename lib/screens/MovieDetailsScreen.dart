import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turnipoff/screens/ActorScreen.dart';
import 'package:turnipoff/widgets/PosterImage.dart';

import '../blocs/Movie/Movie_bloc.dart';
import '../blocs/Movie/Movie_event.dart';
import '../blocs/Movie/Movie_state.dart';
import '../constants/network_constants.dart';
import '../constants/route_constant.dart';
import '../main.dart';
import '../repositories/MovieRepositories.dart';
import '../widgets/CustomLoader.dart';
import '../widgets/PosterFormatImg.dart';
import '../widgets/SeparatorWidget.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({Key? key, required this.movieId}) : super(key: key);
  final String movieId;

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  Widget build(BuildContext context) {
    final MovieRepositoryImpl _repo = MovieRepositoryImpl();
    return SafeArea(
      child: BlocProvider(
        create: (context) =>
            MovieBloc(_repo)..add(LoadMovie(id: widget.movieId)),
        child: BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            return (state is MovieLoaded)
                ? buildBody(state)
                : CustomLoader(
                    color: Theme.of(context).colorScheme.secondary, size: 40);
          },
        ),
      ),
    );
  }

  Widget buildBody(MovieLoaded state) {
    return ListView(
      children: [
        _buildTopScreenImg(state),
        SeparatorWidget(context: context),
        _buildMovieInfo(state),
        SeparatorWidget(context: context),
        _buildSynopsys(state),
        SeparatorWidget(context: context),
        _buildCastAndCrew(state),
      ],
    );
  }

  Stack _buildTopScreenImg(MovieLoaded state) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        backdropImg(state),
        PosterFormatImg(path: state.data?.posterPath)
      ],
    );
  }

  Widget backdropImg(MovieLoaded state) {
    return state.data?.backdropPath != null
        ? ClipRRect(
            child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
                child: CachedNetworkImage(
                    height: 180,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fitWidth,
                    placeholder: (context, url) =>
                        Image.asset('assets/images/img_placeholder.jpeg'),
                    imageUrl: NetworkConstants.LARGE_IMAGE_URL +
                        (state.data!.backdropPath!),
                    fadeOutDuration: const Duration(seconds: 1),
                    fadeInDuration: const Duration(milliseconds: 200))),
          )
        : Container();
  }

  /// Display score, title, releaseDate, and productionCountries
  Widget _buildMovieInfo(MovieLoaded state) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildScore(state, textTheme),
          _buildLastInfo(state, textTheme)
        ],
      ),
    );
  }

  /// Display score
  Container _buildScore(MovieLoaded state, TextTheme textTheme) {
    return Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blueGrey,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(60))),
        child: Center(
          child: Text(
            state.data?.voteAverage?.toString() ?? "",
            style: textTheme.displayMedium,
          ),
        ));
  }

  /// Display releaseDate, and productionCountries
  Widget _buildLastInfo(MovieLoaded state, TextTheme textTheme) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              state.data?.title ?? "",
              textAlign: TextAlign.end,
              style: textTheme.displayMedium,
            ),
            Text(
              (state.data?.releaseDate ?? "") +
                  " " +
                  (state.data?.productionCountries?.firstOrNull?.name ?? ""),
              style: textTheme.displaySmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSynopsys(MovieLoaded state) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Text(
        state.data?.overview ?? "Missing overview",
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.displaySmall,
      ),
    );
  }

  Widget _buildCastAndCrew(MovieLoaded state) {
    final _repo = MovieRepositoryImpl();
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (context) => MovieBloc(_repo)
          ..add(LoadMovieCredits(id: state.data?.id?.toString() ?? "")),
        child: BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            return (state is MovieCreditsLoaded)
                ? Container(
                    child: Column(
                      children: [
                        Text(
                          "Cast",
                          textAlign: TextAlign.start,
                          style: textTheme.displayMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        _getCastList(state),
                        Text(
                          "Crew",
                          textAlign: TextAlign.start,
                          style: textTheme.displayMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        _getCrewList(state)
                      ],
                    ),
                  )
                : CustomLoader(
                    color: Theme.of(context).colorScheme.secondary, size: 40);
          },
        ),
      ),
    );
  }

  SizedBox _getCastList(MovieCreditsLoaded state) {
    return SizedBox(
      height: 250,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: state.data?.cast
                ?.map((cast) => _getPerson(cast.id?.toString(),
                    cast.profilePath, cast.name, cast.character))
                .toList() ??
            [],
      ),
    );
  }

  SizedBox _getCrewList(MovieCreditsLoaded state) {
    return SizedBox(
      height: 250,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: state.data?.crew
                ?.map((crew) => _getPerson(
                    crew.id?.toString(), crew.profilePath, crew.name, crew.job))
                .toList() ??
            [],
      ),
    );
  }

  Widget _getPerson(String? id, String? imgPath, String? name, String? role) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        navigatorKey.currentState?.pushNamed(actor,
            arguments: ActorArgument(
                actorId: id?.toString() ?? "", movieId: widget.movieId));
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: 88,
          child: Column(
            children: [
              _getPersonImg(imgPath),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  name ?? "name",
                  textAlign: TextAlign.center,
                  style: textTheme.displaySmall,
                ),
              ),
              Text(
                role ?? "role",
                textAlign: TextAlign.center,
                style: textTheme.displaySmall?.copyWith(color: Colors.grey),
              )
            ],
          ),
        ),
      ),
    );
  }

  ClipRRect _getPersonImg(String? path) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: PosterImage(url: path));
  }
}

extension<T> on List<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
