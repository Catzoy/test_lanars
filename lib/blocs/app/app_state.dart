import 'package:test_lanars/api/data/api_page.dart';

enum FetchStatus { InProgress, Failed, Success, None }

abstract class AppState {
  final List<ApiPage> pages;
  final int overallNumOfPhotos;
  final FetchStatus fetchStatus;

  AppState(this.pages, this.overallNumOfPhotos, this.fetchStatus)
      : assert(pages != null),
        assert(overallNumOfPhotos != null && overallNumOfPhotos >= 0),
        assert(fetchStatus != null);

  factory AppState.initial() => FeedAppState([], 0, FetchStatus.None);

  toNoneFetchStatus();

  toLoadingPageState();

  toSucceededLoading(ApiPage newPage);

  toFailedLoading();
}

class FeedAppState extends AppState {
  FeedAppState(
    List<ApiPage> pages,
    int overallNumOfPhotos,
    FetchStatus fetchStatus,
  ) : super(pages, overallNumOfPhotos, fetchStatus);

  toNoneFetchStatus() =>
      FeedAppState(pages, overallNumOfPhotos, FetchStatus.None);

  toLoadingPageState() =>
      FeedAppState(pages, overallNumOfPhotos, FetchStatus.InProgress);

  toSucceededLoading(ApiPage newPage) => FeedAppState(
        pages + [newPage],
        overallNumOfPhotos + newPage.photos.length,
        FetchStatus.InProgress,
      );

  toFailedLoading() =>
      FeedAppState(pages, overallNumOfPhotos, FetchStatus.Failed);
}

class PhotoSearchAppState extends AppState {
  final String query;

  PhotoSearchAppState(
    this.query,
    List<ApiPage> pages,
    int overallNumOfPhotos,
    FetchStatus fetchStatus,
  ) : super(pages, overallNumOfPhotos, fetchStatus);

  toNoneFetchStatus() =>
      PhotoSearchAppState(query, pages, overallNumOfPhotos, FetchStatus.None);

  toLoadingPageState() => PhotoSearchAppState(
      query, pages, overallNumOfPhotos, FetchStatus.InProgress);

  toSucceededLoading(ApiPage newPage) => PhotoSearchAppState(
        query,
        pages + [newPage],
        overallNumOfPhotos + newPage.photos.length,
        FetchStatus.InProgress,
      );

  toFailedLoading() =>
      PhotoSearchAppState(query, pages, overallNumOfPhotos, FetchStatus.Failed);
}
