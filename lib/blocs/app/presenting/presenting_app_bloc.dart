import 'dart:async';

import 'package:rebloc/rebloc.dart';
import 'package:test_lanars/blocs/app/app_state.dart';

import 'presenting_actions.dart';

class PresentingAppBloc extends SimpleBloc<AppState> {
  @override
  AppState reducer(AppState state, Action action) {
    switch (action.runtimeType) {
      case LoadingPage:
        return state.copy(fetchStatus: FetchStatus.InProgress);

      case LoadingPageFailed:
        return state.copy(fetchStatus: FetchStatus.Failed);

      case LoadingPageSucceeded:
        final castedAction = action as LoadingPageSucceeded;
        return state.copy(
          pages: state.pages + [castedAction.page],
          fetchStatus: FetchStatus.Success,
        );

      case NotLoadingPage:
        return state.copy(fetchStatus: FetchStatus.None);

      default:
        return state;
    }
  }

  @override
  FutureOr<Action> afterware(
      DispatchFunction dispatcher, AppState state, Action action) async {
    if (state.fetchStatus == FetchStatus.Success ||
        state.fetchStatus == FetchStatus.Failed)
      return const NotLoadingPage();
    else
      return action;
  }
}
