import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rebloc/rebloc.dart';
import 'package:test_lanars/blocs/app/app_state.dart';
import 'package:test_lanars/blocs/app/mutating/side_effect_actions.dart';
import 'package:test_lanars/screens/widgets/photo_preview_tile.dart';
import 'package:test_lanars/screens/widgets/scaffold_with_search_bar.dart';

class _FeedState {
  final AppState appState;
  final int imagesPerPage;
  final String searchQuery;

  _FeedState(this.appState, this.imagesPerPage, this.searchQuery);
}

class Feed extends StatelessWidget {
  final RefreshController controller = RefreshController(
    initialRefresh: true,
  );

  _updateController(FetchStatus status) {
    switch (status) {
      case FetchStatus.Failed:
        if (controller.isLoading) controller.loadFailed();
        if (controller.isRefresh) controller.refreshFailed();
        break;
      case FetchStatus.Success:
        if (controller.isLoading) controller.loadComplete();
        if (controller.isRefresh) controller.refreshCompleted();
        break;
      case FetchStatus.InProgress:
      case FetchStatus.None:
        break;
    }
  }

  _FeedState _convert(AppState state) {
    final String searchQuery =
        state is PhotoSearchAppState ? state.query : null;
    final int imagesPerPage = state.pages.length == 0
        ? 0
        : state.overallNumOfPhotos ~/ state.pages.length;
    _updateController(state.fetchStatus);
    return _FeedState(state, imagesPerPage, searchQuery);
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelSubscriber<AppState, _FeedState>(
      converter: _convert,
      builder: (context, dispatcher, _FeedState state) {
        return ScaffoldWithSearchBar(
          dispatcher: dispatcher,
          body: SafeArea(
            child: SmartRefresher(
              controller: controller,
              enablePullUp: true,
              onRefresh: () => dispatcher(const RefreshFeed()),
              onLoading: () => dispatcher(const LoadNextPage()),
              child: GridView.builder(
                itemCount: state.appState.overallNumOfPhotos,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 8.0,
                ),
                itemBuilder: (context, i) {
                  final currentPage = i ~/ state.imagesPerPage;
                  final currentPhoto = i % state.imagesPerPage;
                  final image =
                      state.appState.pages[currentPage].photos[currentPhoto];
                  return PhotoPreviewTile(image: image);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
