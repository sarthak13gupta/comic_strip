import 'package:flutter/material.dart';

class ComicBox extends StatelessWidget {
  final Image? img;
  const ComicBox({this.img, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[400],
        ),
        child: img ?? const SizedBox.shrink(),
      ),
    );
  }
}
