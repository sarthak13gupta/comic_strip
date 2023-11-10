import 'package:comic_strip/bloc/comic_actions.dart';
import 'package:comic_strip/bloc/comic_bloc.dart';
import 'package:flutter/material.dart';

class ComicForm extends StatefulWidget {
  final ComicBloc comicBloc;
  final bool mobile;
  const ComicForm({required this.comicBloc, required this.mobile, super.key});

  @override
  State<ComicForm> createState() => _ComicFormState();
}

class _ComicFormState extends State<ComicForm> {
  FocusNode _focusNode = FocusNode();
  TextEditingController controller = TextEditingController();
  List<int> comicList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  int comicId = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      // alignment: Alignment,
      child: Column(
        children: [
          DropdownMenu<int>(
              initialSelection: comicList.first,
              dropdownMenuEntries: comicList.map<DropdownMenuEntry<int>>((val) {
                return DropdownMenuEntry<int>(
                  value: val,
                  label: "$val",
                );
              }).toList(),
              onSelected: (val) {
                setState(() {
                  comicId = val!;
                });
              }),
          TextFormField(
            controller: controller,
            focusNode: _focusNode,
            onFieldSubmitted: (value) async {
              widget.comicBloc.comicController
                  .add(FetchComicEvent(value, comicId));

              if (widget.mobile) Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
