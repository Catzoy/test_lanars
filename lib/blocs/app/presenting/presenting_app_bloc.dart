import 'dart:async';

import 'package:rebloc/rebloc.dart';
import 'package:test_lanars/blocs/app/app_state.dart';

import 'presenting_actions.dart';

class PresentingAppBloc extends SimpleBloc<AppState> {
  @override
  AppState reducer(AppState state, Action action) {
    switch (action.runtimeType) {
      case LoadingPage:
        return state.toLoadingPageState();

      case LoadingPageFailed:
        return state.toFailedLoading();

      case LoadingPageSucceeded:
        final castedAction = action as LoadingPageSucceeded;
        return state.toSucceededLoading(castedAction.page);

      case NotLoadingPage:
        return state.toNoneFetchStatus();

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
