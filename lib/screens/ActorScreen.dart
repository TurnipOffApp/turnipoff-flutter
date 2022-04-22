import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turnipoff/blocs/Actor/Actor.dart';
import 'package:turnipoff/widgets/PosterFormatImg.dart';

import '../blocs/Actor/Actor_bloc.dart';
import '../blocs/Actor/Actor_event.dart';
import '../repositories/ActorRepositories.dart';
import '../widgets/CustomLoader.dart';
import '../widgets/SeparatorWidget.dart';

class ActorScreen extends StatefulWidget {
  const ActorScreen({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<ActorScreen> createState() => _ActorScreenState();
}

class _ActorScreenState extends State<ActorScreen> {
  final ActorRepositoryImpl _repo = ActorRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => ActorBloc(_repo)..add(LoadActor(id: widget.id)),
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
        PosterFormatImg(path: state.data?.profilePath),
        SeparatorWidget(context: context),
        _buildActorInfo(state),
        SeparatorWidget(context: context),
        _buildSynopsys(state),
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
          _buildPopularity(state, textTheme),
          _buildLastInfo(state, textTheme)
        ],
      ),
    );
  }

  /// Display popularity
  Container _buildPopularity(ActorLoaded state, TextTheme textTheme) {
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
            state.data?.popularity?.toInt().toString() ?? "",
            style: textTheme.displayMedium,
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
}
