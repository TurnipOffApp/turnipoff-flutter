import 'package:bloc/bloc.dart';
import 'package:turnipoff/blocs/Trends/trends_event.dart';
import 'package:turnipoff/blocs/Trends/trends.dart';
import 'package:turnipoff/models/TrendsData.dart';
import 'package:turnipoff/repositories/TrendsRepositories.dart';

class TrendsBloc extends Bloc<TrendsEvent, TrendsState> {
  final TrendsRepositoryImpl _trendsRepository;

  TrendsBloc(this._trendsRepository)
      : super(TrendsLoadInProgress()) {
    on<LoadTrends>(_onLoadTrends);
    on<LoadingTrendsFailed>(_onLoadingTrendsFailed);
  }

  void _onLoadTrends(
      LoadTrends event, Emitter<TrendsState> emit) async {
    try {
      TrendsData data = await _trendsRepository.getTrends();
      emit((TrendsLoaded()).copyWith(data: data));
    } catch (_) {
      add(LoadingTrendsFailed());
    }
  }

  void _onLoadingTrendsFailed(
      LoadingTrendsFailed event, Emitter emit) {
    emit(TrendsLoadingFailure());
  }

}
