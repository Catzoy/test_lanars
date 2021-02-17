import 'package:rebloc/rebloc.dart';
import 'package:test_lanars/api/data/api_page.dart';

class LoadingPage extends Action {
  const LoadingPage();
}

class LoadingPageFailed extends Action {
  const LoadingPageFailed();
}

class LoadingPageSucceeded extends Action {
  final ApiPage page;
  const LoadingPageSucceeded(this.page);
}

class NotLoadingPage extends Action {
  const NotLoadingPage();
}

final presentingFeedActions = [
  LoadingPage,
  LoadingPageFailed,
  LoadingPageSucceeded,
  NotLoadingPage,
];
