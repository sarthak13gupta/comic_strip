import 'dart:async';

import 'package:comic_strip/bloc/comic_actions.dart';
import 'package:comic_strip/bloc/comic_model.dart';
import 'package:comic_strip/utils/api.dart';
import 'package:comic_strip/widgets/show_error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ComicBloc {
  final BehaviorSubject<ComicEvent> comicController =
      BehaviorSubject<ComicEvent>();
  Stream<ComicEvent> get comicStream => comicController.stream;

  final StreamController<String> _updateController =
      StreamController<String>.broadcast();
  Stream<String> get updateStream => _updateController.stream;

  final StreamController<bool> _loadingStateController =
      StreamController<bool>.broadcast();
  Stream<bool> get loadingStateStream => _loadingStateController.stream;

  ComicBloc() {
    init();
  }

  void init() {
    comicStream.listen((event) async {
      if (event is FetchComicEvent) {
        await _fetchComicImage(event.context, event.comicId, event.input);
      } else if (event is HandleError) {
        _handleError(event.message, event.context);
      }
    });
  }

  Future<void> _fetchComicImage(
      BuildContext context, int id, String input) async {
    _loadingStateController.add(true);
    Image img = await generateImage(input, id, context).catchError((error) {
      _loadingStateController.add(false);
      throw Exception(error);
    });

    _loadingStateController.add(false);
    ComicModel.comicImgMap.update(id, (value) => img, ifAbsent: () => img);
    _updateController.add("success");
  }

  Future<void> _handleError(List<String> message, BuildContext context) async {
    _loadingStateController.add(false);
    await showErrorDialog(context: context, message: message);
  }
}
