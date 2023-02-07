import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turnipoff/screens/ActorScreen.dart';
import 'package:turnipoff/widgets/GenericSection.dart';
import 'package:turnipoff/widgets/Poster.dart';

import '../blocs/Movie/Movie_bloc.dart';
import '../blocs/Movie/Movie_event.dart';
import '../blocs/Movie/Movie_state.dart';
import '../constants/route_constant.dart';
import '../main.dart';
import '../repositories/MovieRepositories.dart';
import '../widgets/CustomLoader.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie details"),
        leading: const BackButton()
      ),
      body: BlocProvider(
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
    return SingleChildScrollView(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Poster(
              url: state.data?.posterPath,
              format: PosterFormat.w342,
              height: MediaQuery.of(context).size.height / 4),
        ),
        SeparatorWidget(context: context),
        _buildMovieInfo(state),
        SeparatorWidget(context: context),
        _buildSynopsys(state),
        SeparatorWidget(context: context),
        _buildCastAndCrew(state),
      ],
    ));
  }

  /// Display score, title, releaseDate, and productionCountries
  Widget _buildMovieInfo(MovieLoaded state) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(12.0),
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
        width: 48,
        height: 48,
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(48)),
        child: Center(
          child: Text(
            state.data?.voteAverage?.toString() ?? "",
            style: textTheme.titleMedium,
          ),
        ));
  }

  /// Display releaseDate, and productionCountries
  Widget _buildLastInfo(MovieLoaded state, TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          state.data?.title ?? "",
          textAlign: TextAlign.end,
          style: textTheme.titleMedium,
        ),
        Text(
          state.data?.genres?.map((e) => e.name).join(", ") ?? "",
          textAlign: TextAlign.end,
          style: textTheme.labelMedium,
        ),
        Text(
          state.data?.releaseDate?.substring(0, 4) ?? "",
          style: textTheme.labelMedium,
        ),
        Text(
          Duration(minutes: state.data?.runtime ?? 0)
              .toString()
              .split('.')[0]
              .padLeft(8, '0'),
          style: textTheme.labelMedium,
        ),
      ],
    );
  }

  Widget _buildSynopsys(MovieLoaded state) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        state.data?.overview ?? "Missing overview",
        style: Theme.of(context).textTheme.labelLarge,
      ),
    );
  }

  Widget _buildCastAndCrew(MovieLoaded state) {
    final _repo = MovieRepositoryImpl();
    return BlocProvider(
        create: (context) => MovieBloc(_repo)
          ..add(LoadMovieCredits(id: state.data?.id?.toString() ?? "")),
        child: BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            return (state is MovieCreditsLoaded)
                ? Column(
                    children: [
                      GenericSection(
                          title: "Cast",
                          items: state.data!.cast!.map((cast) =>
                              GenericSectionItem(
                                  id: cast.id,
                                  imagePath: cast.profilePath,
                                  title: cast.name,
                                  subTitle: cast.character)),
                          onItemClicked: (item) => {
                                navigatorKey.currentState?.pushNamed(actor,
                                    arguments: ActorArgument(
                                        actorId: item.id.toString(),
                                        movieId: widget.movieId))
                              }),
                      SeparatorWidget(context: context),
                      GenericSection(
                          title: "Crew",
                          items: state.data!.crew!.map((crew) =>
                              GenericSectionItem(
                                  id: crew.id,
                                  imagePath: crew.profilePath,
                                  title: crew.name,
                                  subTitle: crew.job)),
                          onItemClicked: (item) => {
                                navigatorKey.currentState?.pushNamed(actor,
                                    arguments: ActorArgument(
                                        actorId: item.id.toString(),
                                        movieId: widget.movieId))
                              }),
                    ],
                  )
                : CustomLoader(
                    color: Theme.of(context).colorScheme.secondary, size: 40);
          },
        )
    );
  }
}
