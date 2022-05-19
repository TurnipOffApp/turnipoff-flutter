import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turnipoff/blocs/Actor/Actor.dart';
import 'package:turnipoff/widgets/PosterFormatImg.dart';
import 'package:turnipoff/widgets/PosterImage.dart';

import '../constants/route_constant.dart';
import '../main.dart';
import '../repositories/ActorRepositories.dart';
import '../widgets/CustomLoader.dart';
import '../widgets/SeparatorWidget.dart';

class ActorArgument {
  final String actorId;
  final String movieId;

  ActorArgument({required this.actorId, required this.movieId});
}

class ActorScreen extends StatefulWidget {
  const ActorScreen({Key? key, required this.actorArgument}) : super(key: key);
  final ActorArgument actorArgument;

  @override
  State<ActorScreen> createState() => _ActorScreenState();
}

class _ActorScreenState extends State<ActorScreen> {
  final ActorRepositoryImpl _repo = ActorRepositoryImpl();
  ValueNotifier<String> averageNotifier = ValueNotifier("...");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) =>
            ActorBloc(_repo)..add(LoadActor(id: widget.actorArgument.actorId)),
        child: BlocBuilder<ActorBloc, ActorState>(
          builder: (context, state) {
            return (state is ActorLoaded)
                ? buildBody(state)
                : CustomLoader(
                    color: Theme.of(context).colorScheme.secondary, size: 40);
          },
        ),
      ),
    );
  }

  Widget buildBody(ActorLoaded state) {
    return ListView(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            PosterFormatImg(path: state.data?.profilePath)
          ],
        ),
        SeparatorWidget(context: context),
        _buildActorInfo(state),
        SeparatorWidget(context: context),
        _buildSynopsys(state),
        SeparatorWidget(context: context),
        _buildCastAndCrew(widget.actorArgument.actorId)
      ],
    );
  }

  /// Display score, title, releaseDate, and productionCountries
  Widget _buildActorInfo(ActorLoaded state) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildPopularity(textTheme),
          _buildLastInfo(state, textTheme)
        ],
      ),
    );
  }

  /// Display popularity
  Container _buildPopularity(TextTheme textTheme) {
    return Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blueGrey,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(60))),
        child: Center(
          child: ValueListenableBuilder<String>(
            valueListenable: averageNotifier,
            builder: (context, value, _) {
              return Text(
                averageNotifier.value,
                style: textTheme.displayMedium,
              );
            },
          ),
        ));
  }

  /// Display name, birthday and deathday (if not null)
  Widget _buildLastInfo(ActorLoaded state, TextTheme textTheme) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              state.data?.name ?? "",
              textAlign: TextAlign.end,
              style: textTheme.displayMedium,
            ),
            Text(
              (state.data?.birthday ?? "") +
                  " - " +
                  (state.data?.deathday ?? "") +
                  (state.data?.knownForDepartment ?? ""),
              style: textTheme.displaySmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSynopsys(ActorLoaded state) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Text(
        state.data?.biography ?? "Missing biography",
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.displaySmall,
      ),
    );
  }

  Widget _buildCastAndCrew(String? id) {
    final _repo = ActorRepositoryImpl();
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (context) =>
            ActorBloc(_repo)..add(LoadActorCredits(id: id ?? "")),
        child: BlocBuilder<ActorBloc, ActorState>(
          builder: (context, state) {
            return (state is ActorCreditsLoaded)
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

  SizedBox _getCastList(ActorCreditsLoaded state) {
    _notifyAverageListerWhenReady(state);
    return SizedBox(
      height: 250,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: state.data?.cast
                ?.map((cast) => _getMovie(cast.id?.toString(), cast.movieImg,
                    cast.movieTitle, cast.character))
                .toList() ??
            [],
      ),
    );
  }

  void _notifyAverageListerWhenReady(ActorCreditsLoaded state) {
    Future.delayed(Duration.zero, () async {
      //Wait for the next Tick
      averageNotifier.value = state.data?.cast
              ?.map((e) => e.averageVote ?? 0.0)
              .average
              .toString()
              .substring(0, 3) ??
          "...";
    });
  }

  SizedBox _getCrewList(ActorCreditsLoaded state) {
    return SizedBox(
      height: 250,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: state.data?.crew
                ?.map((crew) => _getMovie(crew.id?.toString(), crew.movieImg,
                    crew.movieTitle, crew.job))
                .toList() ??
            [],
      ),
    );
  }

  Widget _getMovie(String? id, String? imgPath, String? name, String? role) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        navigatorKey.currentState?.pushNamed(moviePath, arguments: id);
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
