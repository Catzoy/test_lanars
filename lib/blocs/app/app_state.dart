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

  AppState toNoneFetchStatus();

  AppState toLoadingPageState();

  AppState toSucceededLoading(ApiPage newPage);

  AppState toSuccessRefresh(ApiPage newPage);

  AppState toFailedLoading();
}

class FeedAppState extends AppState {
  FeedAppState(
    List<ApiPage> pages,
    int overallNumOfPhotos,
    FetchStatus fetchStatus,
  ) : super(pages, overallNumOfPhotos, fetchStatus);

  AppState toNoneFetchStatus() =>
      FeedAppState(pages, overallNumOfPhotos, FetchStatus.None);

  AppState toLoadingPageState() =>
      FeedAppState(pages, overallNumOfPhotos, FetchStatus.InProgress);

  AppState toSucceededLoading(ApiPage newPage) => FeedAppState(
        pages + [newPage],
        overallNumOfPhotos + newPage.photos.length,
        FetchStatus.Success,
      );

  AppState toSuccessRefresh(ApiPage newPage) =>
      FeedAppState([newPage], newPage.photos.length, FetchStatus.Success);

  AppState toFailedLoading() =>
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

  AppState toNoneFetchStatus() =>
      PhotoSearchAppState(query, pages, overallNumOfPhotos, FetchStatus.None);

  AppState toLoadingPageState() => PhotoSearchAppState(
      query, pages, overallNumOfPhotos, FetchStatus.InProgress);

  AppState toSucceededLoading(ApiPage newPage) => PhotoSearchAppState(
        query,
        pages + [newPage],
        overallNumOfPhotos + newPage.photos.length,
        FetchStatus.Success,
      );

  AppState toSuccessRefresh(ApiPage newPage) => PhotoSearchAppState(
      query, [newPage], newPage.photos.length, FetchStatus.Success);

  AppState toFailedLoading() =>
      PhotoSearchAppState(query, pages, overallNumOfPhotos, FetchStatus.Failed);
}
