import 'package:comic_strip/bloc/comic_bloc.dart';
import 'package:comic_strip/bloc/comic_model.dart';
import 'package:comic_strip/widgets/comicBox.dart';
import 'package:comic_strip/widgets/comic_form.dart';
import 'package:comic_strip/widgets/loader.dart';
import 'package:flutter/material.dart';

class DeskTopView extends StatefulWidget {
  final ComicBloc comicBloc;
  final bool isLoading;
  const DeskTopView(
      {required this.comicBloc, required this.isLoading, super.key});

  @override
  State<DeskTopView> createState() => _DeskTopViewState();
}

class _DeskTopViewState extends State<DeskTopView> {
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 350,
          child: ComicForm(
            ctx: context,
            comicBloc: widget.comicBloc,
            mobile: false,
          ),
        ),
        const VerticalDivider(),
        widget.isLoading == false
            ? Expanded(
                child: GridView.builder(
                  itemCount: 10,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
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
