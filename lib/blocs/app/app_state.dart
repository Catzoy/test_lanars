import 'package:test_lanars/api/data/api_page.dart';

enum FetchStatus { InProgress, Failed, Success, None }

abstract class AppState {
  final List<ApiPage> pages;
  final FetchStatus fetchStatus;

  AppState(this.pages, this.fetchStatus)
      : assert(pages != null),
        assert(fetchStatus != null);

  AppState copy({List<ApiPage> pages, FetchStatus fetchStatus});
}

class FeedAppState extends AppState {
  FeedAppState(List<ApiPage> pages, FetchStatus fetchStatus)
      : super(pages, fetchStatus);

  FeedAppState copy({List<ApiPage> pages, FetchStatus fetchStatus}) {
    return FeedAppState(
      pages ?? this.pages,
      fetchStatus ?? this.fetchStatus,
    );
  }
}

class PhotoSearchAppState extends AppState {
  final String query;

  PhotoSearchAppState(
    this.query,
    List<ApiPage> pages,
    FetchStatus fetchStatus,
  ) : super(pages, fetchStatus);

  PhotoSearchAppState copy({List<ApiPage> pages, FetchStatus fetchStatus}) {
    return PhotoSearchAppState(
      query,
      pages ?? this.pages,
      fetchStatus ?? this.fetchStatus,
    );
  }
}
