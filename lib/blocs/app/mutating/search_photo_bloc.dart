import 'dart:async';

import 'package:rebloc/rebloc.dart';
import 'package:test_lanars/api/unsplash_api.dart';
import 'package:test_lanars/blocs/app/app_state.dart';
import 'package:test_lanars/blocs/app/presenting/presenting_actions.dart';

import 'side_effect_actions.dart';

class SearchPhotoBloc extends SimpleBloc<AppState> {
  final UnsplashApi api;

  SearchPhotoBloc(this.api);

  Future<Action> _loadNextSearchPage(
      PhotoSearchAppState searchPhotoState) async {
    final nextPageNum = searchPhotoState.pages.length + 1;
    try {
      final nextPage = await api.searchPhotos(
        searchPhotoState.query,
        page: nextPageNum,
      );
      return LoadingPageSucceeded(nextPage);
    } catch (e) {
      return const LoadingPageFailed();
    }
  }

  Future<Action> _refreshSearch(PhotoSearchAppState searchPhotoState) async {
    try {
      final nextPage = await api.searchPhotos(
        searchPhotoState.query,
      );
      return RefreshFeedSucceeded(nextPage);
    } catch (e) {
      return const LoadingPageFailed();
    }
  }

  FutureOr<Action> middleware(
    DispatchFunction dispatcher,
    AppState state,
    Action action,
  ) async {
    if (!(state is PhotoSearchAppState)) return action;

    switch (action.runtimeType) {
      case RefreshFeed:
        return await _refreshSearch(state);

      case LoadNextPage:
        return await _loadNextSearchPage(state);

      default:
        return action;
    }
  }
}
