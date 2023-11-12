import 'package:comic_strip/bloc/comic_bloc.dart';
import 'package:comic_strip/bloc/comic_model.dart';
import 'package:comic_strip/widgets/comicBox.dart';
import 'package:comic_strip/widgets/comic_form.dart';
import 'package:comic_strip/widgets/loader.dart';
import 'package:flutter/material.dart';

class TabletView extends StatefulWidget {
  final ComicBloc comicBloc;
  final bool isLoading;
  const TabletView(
      {required this.comicBloc, required this.isLoading, super.key});

  @override
  State<TabletView> createState() => _TabletViewState();
}

class _TabletViewState extends State<TabletView> {
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 250,
          child: ComicForm(
            ctx: context,
            comicBloc: widget.comicBloc,
            mobile: false,
          ),
        ),
        widget.isLoading == false
            ? Expanded(
                child: GridView.builder(
                  itemCount: 10,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
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
              )
            : const Loader(),
      ],
    );
  }
}
