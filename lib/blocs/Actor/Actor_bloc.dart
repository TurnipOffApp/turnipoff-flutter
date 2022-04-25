import 'package:bloc/bloc.dart';
import 'package:turnipoff/blocs/Actor/Actor_event.dart';
import 'package:turnipoff/blocs/Actor/Actor_state.dart';
import 'package:turnipoff/models/ActorData.dart';
import 'package:turnipoff/models/CreditsData.dart';
import 'package:turnipoff/repositories/ActorRepositories.dart';

import '../../models/CreditsData.dart';

class ActorBloc extends Bloc<ActorEvent, ActorState> {
  final ActorRepositoryImpl _ActorRepository;

  ActorBloc(this._ActorRepository)
      : super(ActorLoadInProgress()) {
    on<LoadActor>(onLoadActor);
    on<LoadActorCredits>(onLoadActorCredits);
    on<LoadingActorFailed>(_onLoadingInformationFailed);
  }

  void onLoadActor(
      LoadActor event, Emitter<ActorState> emit) async {
    try {
      ActorData data = await _ActorRepository.getActor(event.id);
      emit((ActorLoaded()).copyWith(data: data));
    } catch (_) {
      add(LoadingActorFailed());
    }
  }

  void onLoadActorCredits(LoadActorCredits event, Emitter<ActorState> emit) async {
    try {
      CreditsData data = await _ActorRepository.getActorCredits(event.id);
      emit((ActorCreditsLoaded()).copyWith(data: data));
    } catch (_) {
      add(LoadingActorFailed());
    }
  }

  void _onLoadingInformationFailed(
      LoadingActorFailed event, Emitter emit) {
    emit(ActorLoadingFailure());
  }

}
