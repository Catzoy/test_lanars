import 'package:rebloc/rebloc.dart';

class LoadNextPage extends Action {
  const LoadNextPage();
}

class RefreshFeed extends Action {
  const RefreshFeed();
}

final mutatingAppStateActions = [LoadNextPage, RefreshFeed];
