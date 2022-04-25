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
  CUSTOM_TRENDS,
  ACTION,
  COMEDY,
  EIGHTYS,
  NINETEES
}
