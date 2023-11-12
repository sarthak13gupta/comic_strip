// Events
import 'package:flutter/material.dart';

abstract class ComicEvent {}

class FetchComicEvent extends ComicEvent {
  final String input;
  final int comicId;
  final BuildContext context;

  FetchComicEvent(this.context, this.input, this.comicId);
}

class HandleError extends ComicEvent {
  final List<String> message;
  final BuildContext context;
  HandleError(this.message, this.context);
}

// States
abstract class ComicState {}

class InitialComicState extends ComicState {}

class UpdatedComicState extends ComicState {}
