import 'package:flutter/material.dart';
import 'package:rebloc/rebloc.dart';
import 'package:test_lanars/blocs/app/app_state.dart';
import 'package:test_lanars/blocs/app/mutating/side_effect_actions.dart';

class _FeedState {
  final AppState appState;
  final int imagesPerPage;
  final String searchQuery;

  _FeedState(this.appState, this.imagesPerPage, this.searchQuery);
}

class Feed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ViewModelSubscriber<AppState, _FeedState>(
        converter: (AppState state) => _FeedState(
          state,
          state.overallNumOfPhotos ~/ state.pages.length,
          state is PhotoSearchAppState ? "" : null,
        ),
        builder: (context, dispatcher, _FeedState state) {
          return GestureDetector(
            onTap: () => dispatcher(const LoadNextPage()),
            child: ListView.builder(
              itemCount: state.appState.overallNumOfPhotos,
              itemBuilder: (context, i) {
                final currentPage = i ~/ state.imagesPerPage;
                final currentPhoto = i % state.imagesPerPage;
                final image =
                    state.appState.pages[currentPage].photos[currentPhoto];
                return ListTile(
                  leading: Image.network(
                    image.thumbUrl,
                  ),
                  title: Text("Image(${image.id})"),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
