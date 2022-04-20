import 'package:bloc/bloc.dart';
import 'package:turnipoff/blocs/MoviePreview/MoviePreview_event.dart';
import 'package:turnipoff/blocs/MoviePreview/MoviePreview_state.dart';
import 'package:turnipoff/models/MoviePreviewData.dart';
import 'package:turnipoff/repositories/MoviePreviewRepositories.dart';

class MoviePreviewBloc extends Bloc<MoviePreviewEvent, MoviePreviewState> {
  final MoviePreviewRepositoryImpl _moviePreviewRepository;
  //Map<int, int> page = {0:0,0:0,0:0,0:0};
  //Map<int, bool> isFetching = {0:false,0:false,0:false,0:false};

  MoviePreviewBloc(this._moviePreviewRepository)
      : super(MoviePreviewLoadInProgress()) {
    on<LoadMoviePreview>(_onLoadMoviePreview);
    on<LoadingMoviePreviewFailed>(_onLoadingInformationFailed);
  }

  void _onLoadMoviePreview(
      LoadMoviePreview event, Emitter<MoviePreviewState> emit) async {
    MoviePreviewData data;
    try {
      switch (event.type) {
        case PreviewType.ACTION:
          data = await _moviePreviewRepository.getActionPreview();
          break;
        case PreviewType.COMEDY:
          data = await _moviePreviewRepository.getComedyPreview();
          break;
        case PreviewType.EIGHTYS:
          data = await _moviePreviewRepository.getEightysPreview();
          break;
        case PreviewType.NINETEES:
          data = await _moviePreviewRepository.getNineteensPreview();
          break;
        default :
          data = await _moviePreviewRepository.getActionPreview();
          break;
      }
      emit((MoviePreviewLoaded()).copyWith(data: data));
    } catch (_) {
      add(LoadingMoviePreviewFailed());
    }
  }

  void _onLoadingInformationFailed(
      LoadingMoviePreviewFailed event, Emitter emit) {
    emit(MoviePreviewLoadingFailure());
  }
}
