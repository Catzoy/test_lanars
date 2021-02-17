import 'package:flutter/material.dart';
import 'package:rebloc/rebloc.dart';
import 'package:test_lanars/api/unsplash_api.dart';
import 'package:test_lanars/screens/feed.dart';

import 'blocs/app/app_blocs.dart';

void main() {
  final unsplashApi = UnsplashApi();

  final store = Store(
    initialState: AppState.initial(),
    blocs: [
      PhotosFeedBloc(unsplashApi),
      SearchPhotoBloc(unsplashApi),
      PresentingAppBloc(),
    ],
  );

  runApp(
    StoreProvider(
      store: store,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Feed(),
    );
  }
}
