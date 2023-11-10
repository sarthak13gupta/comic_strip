// Events
abstract class ComicEvent {}

class FetchComicEvent extends ComicEvent {
  final String input;
  final int comicId;

  FetchComicEvent(this.input, this.comicId);
}

// States
abstract class ComicState {}

class InitialComicState extends ComicState {}

class UpdatedComicState extends ComicState {}
