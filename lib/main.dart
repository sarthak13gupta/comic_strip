import 'package:comic_strip/bloc/comic_bloc.dart';
import 'package:comic_strip/views/desktop_view.dart';
import 'package:comic_strip/views/mobile_view.dart';
import 'package:comic_strip/views/tablet_view.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final comicBloc = ComicBloc();
  bool isLoading = false;
  void initState() {
    super.initState();
    _setListener();
  }

  void _setListener() {
    comicBloc.updateStream.listen((event) {
      setState(() {});
    });
    comicBloc.loadingStateStream.listen((event) {
      setState(() {
        isLoading = event;
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
            return DeskTopView(
              comicBloc: comicBloc,
              isLoading: isLoading,
            );
          }

          if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
            return TabletView(
              comicBloc: comicBloc,
              isLoading: isLoading,
            );
          }
          return MobileView(
            comicBloc: comicBloc,
            isLoading: isLoading,
          );
        },
      ),
    );
  }
}
