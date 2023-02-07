import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turnipoff/blocs/Actor/Actor.dart';
import 'package:turnipoff/widgets/Poster.dart';

import '../constants/route_constant.dart';
import '../main.dart';
import '../repositories/ActorRepositories.dart';
import '../widgets/CustomLoader.dart';
import '../widgets/GenericSection.dart';
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
    return Scaffold(
      appBar: AppBar(
          title: const Text("Person details"), leading: const BackButton()),
      body: BlocProvider(
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
    return SingleChildScrollView(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Poster(
              url: state.data?.profilePath,
              format: PosterFormat.w185,
              height: MediaQuery.of(context).size.height / 4.2),
        ),
        SeparatorWidget(context: context),
        _buildActorInfo(state),
        SeparatorWidget(context: context),
        _buildSynopsys(state),
        SeparatorWidget(context: context),
        _buildCastAndCrew(widget.actorArgument.actorId)
      ],
    ));
  }

  /// Display score, title, releaseDate, and productionCountries
  Widget _buildActorInfo(ActorLoaded state) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(12.0),
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
        width: 48,
        height: 48,
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(48))),
        child: Center(
          child: ValueListenableBuilder<String>(
            valueListenable: averageNotifier,
            builder: (context, value, _) {
              return Text(
                averageNotifier.value,
                style: textTheme.titleMedium,
              );
            },
          ),
        ));
  }

  /// Display name, birthday and deathday (if not null)
  Widget _buildLastInfo(ActorLoaded state, TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          state.data?.name ?? "",
          textAlign: TextAlign.end,
          style: textTheme.titleMedium,
        ),
        Text(
          (state.data?.birthday ?? "") +
              " - " +
              (state.data?.deathday ?? "") +
              (state.data?.knownForDepartment ?? ""),
          style: textTheme.labelMedium,
        ),
        Text(
          (state.data?.placeOfBirth ?? ""),
          style: textTheme.labelMedium,
        ),
      ],
    );
  }

  Widget _buildSynopsys(ActorLoaded state) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Text(
        state.data?.biography ?? "Missing biography",
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.labelLarge,
      ),
    );
  }

  Widget _buildCastAndCrew(String? id) {
    final _repo = ActorRepositoryImpl();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (context) =>
            ActorBloc(_repo)..add(LoadActorCredits(id: id ?? "")),
        child: BlocBuilder<ActorBloc, ActorState>(
          builder: (context, state) {
            if (state is ActorCreditsLoaded) {
              _notifyAverageListerWhenReady(state);
              return Column(
                children: [
                  GenericSection(
                      title: "Cast",
                      items: state.data!.cast!.map((cast) => GenericSectionItem(
                          id: cast.id,
                          imagePath: cast.movieImg,
                          title: cast.movieTitle,
                          subTitle: cast.character)),
                      onItemClicked: (item) => {
                            navigatorKey.currentState?.pushNamed(moviePath,
                                arguments: item.id.toString())
                          }),
                  SeparatorWidget(context: context),
                  GenericSection(
                      title: "Crew",
                      items: state.data!.crew!.map((crew) => GenericSectionItem(
                          id: crew.id,
                          imagePath: crew.profilePath,
                          title: crew.name,
                          subTitle: crew.job)),
                      onItemClicked: (item) => {
                            navigatorKey.currentState?.pushNamed(moviePath,
                                arguments: item.id.toString())
                          }),
                ],
              );
            } else {
              return CustomLoader(
                  color: Theme.of(context).colorScheme.secondary, size: 40);
            }
          },
        ),
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
}
