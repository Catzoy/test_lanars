import 'dart:async';

import 'package:rebloc/rebloc.dart';
import 'package:test_lanars/blocs/app/app_blocs.dart';
import 'package:test_lanars/blocs/app/mutating/side_effect_actions.dart';

class SearchControlBloc extends SimpleBloc<AppState> {
  FutureOr<Action> afterware(
      DispatchFunction dispatcher, AppState state, Action action) {
    if (action is StartSearch) dispatcher(LoadNextPage());
    return action;
  }

  @override
  AppState reducer(AppState state, Action action) {
    switch (action.runtimeType) {
      case StartSearch:
        final casted = action as StartSearch;
        return PhotoSearchAppState(
          casted.query,
          [],
          0,
          FetchStatus.InProgress,
        );

      case EndSearch:
        return FeedAppState(
          [],
          0,
          FetchStatus.None,
        );

      default:
        return state;
    }
  }
}
