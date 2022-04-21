import 'package:equatable/equatable.dart';

abstract class MoviePreviewEvent extends Equatable {
  PreviewType type;
  MoviePreviewEvent({required this.type});
  @override
  List<Object> get props => [];
}

class MoviePreviewFetched extends MoviePreviewEvent {
  MoviePreviewFetched({required PreviewType type}) : super(type: type);
}


enum PreviewType {
  ACTION,
  COMEDY,
  EIGHTYS,
  NINETEES
}
