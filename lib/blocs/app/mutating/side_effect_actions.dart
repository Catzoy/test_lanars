import 'package:rebloc/rebloc.dart';

class LoadNextPage extends Action {
  const LoadNextPage();
}

class RefreshFeed extends Action {
  const RefreshFeed();
}

class StartSearch extends Action {
  final String query;
  const StartSearch(this.query);
}

class EndSearch extends Action {
  const EndSearch();
}

final feedManipulationActions = [LoadNextPage, RefreshFeed];
final searchManipulationActions = [StartSearch, EndSearch];
