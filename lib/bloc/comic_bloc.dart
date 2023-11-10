import 'dart:async';

import 'package:comic_strip/bloc/comic_actions.dart';
import 'package:comic_strip/bloc/comic_model.dart';
import 'package:comic_strip/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ComicBloc {
  final BehaviorSubject<ComicEvent> comicController =
      BehaviorSubject<ComicEvent>();
  Stream<ComicEvent> get comicStream => comicController.stream;

  final StreamController<String> _updateController =
      StreamController<String>.broadcast();
  Stream<String> get updateStream => _updateController.stream;

  ComicBloc() {
    init();
  }

  void init() {
    comicStream.listen((event) {
      if (event is FetchComicEvent) {
        _fetchComicImage(event.comicId, event.input);
      }
    });
  }

  Future<void> _fetchComicImage(int id, String input) async {
    Image img = await generateImage(input, id);
    ComicModel.comicImgMap.update(id, (value) => img, ifAbsent: () => img);
    _updateController.add("success");
  }
}
