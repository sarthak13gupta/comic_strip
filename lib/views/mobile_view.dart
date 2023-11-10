import 'package:comic_strip/bloc/comic_bloc.dart';
import 'package:comic_strip/bloc/comic_model.dart';
import 'package:comic_strip/widgets/comicBox.dart';
import 'package:comic_strip/widgets/comic_form.dart';
import 'package:flutter/material.dart';

class MobileView extends StatefulWidget {
  final ComicBloc comicBloc;
  const MobileView({required this.comicBloc, super.key});

  @override
  State<MobileView> createState() => _MobileViewState();
}

class _MobileViewState extends State<MobileView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Expanded(
          child: GridView.builder(
            itemCount: 10,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
            ),
            itemBuilder: (context, index) {
              Image? img;
              if (ComicModel.comicImgMap.containsKey(index + 1)) {
                img = ComicModel.comicImgMap[index + 1];
              } else {
                img = null;
              }
              return ComicBox(img: img);
            },
          ),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: FloatingActionButton(
            onPressed: () {
              _showModalBottomSheet(context);
            },
          ),
        )
      ],
    );
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ComicForm(comicBloc: widget.comicBloc, mobile: true);
      },
    );
  }
}
