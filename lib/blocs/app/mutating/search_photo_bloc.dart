import 'dart:async';

import 'package:rebloc/rebloc.dart';
import 'package:test_lanars/api/unsplash_api.dart';
import 'package:test_lanars/blocs/app/app_state.dart';
import 'package:test_lanars/blocs/app/presenting/presenting_actions.dart';

import 'side_effect_actions.dart';

class SearchPhotoBloc extends SimpleBloc<AppState> {
  final UnsplashApi api;

  SearchPhotoBloc(this.api);

  FutureOr<Action> middleware(
    DispatchFunction dispatcher,
    AppState state,
    Action action,
  ) async {
    if (!(state is PhotoSearchAppState)) return action;
    if (!mutatingAppStateActions.contains(action.runtimeType)) return action;

    final searchPhotoState = state as PhotoSearchAppState;
    final nextPageNum = searchPhotoState.pages.length + 1;
    dispatcher(const LoadingPage());

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
}
