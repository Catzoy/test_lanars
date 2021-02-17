import 'dart:async';

import 'package:rebloc/rebloc.dart';
import 'package:test_lanars/api/unsplash_api.dart';
import 'package:test_lanars/blocs/app/app_state.dart';
import 'package:test_lanars/blocs/app/presenting/presenting_actions.dart';

import 'side_effect_actions.dart';

class PhotosFeedBloc extends SimpleBloc<AppState> {
  final UnsplashApi api;

  PhotosFeedBloc(this.api);

  Future<Action> _loadNextPage(FeedAppState state) async {
    final nextPageNum = state.pages.length + 1;

    try {
      final nextPage = await api.retrievePhotos(page: nextPageNum);
      return LoadingPageSucceeded(nextPage);
    } catch (e) {
      return const LoadingPageFailed();
    }
  }

  Future<Action> _refreshFeed() async {
    try {
      final nextPage = await api.retrievePhotos();
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
    if (!(state is FeedAppState)) return action;

    switch (action.runtimeType) {
      case RefreshFeed:
        return await _refreshFeed();

      case LoadNextPage:
        return await _loadNextPage(state);

      default:
        return action;
    }
  }
}
