import 'package:dio/dio.dart';

import 'data/api_page.dart';
import 'secret.dart';

class UnsplashApi {
  static const _baseUrl = "https://api.unsplash.com/";
  static const _photosFeedPath = "/photos";
  static const _searchPhotoPath = "/search/photos";

  final _dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      headers: {
        "Authorization": "Client-ID ${ApiSecret.ACCESS_KEY}",
      },
    ),
  );

  Future<ApiPage> retrievePhotos({int page = 1}) async {
    final response = await _dio.get(
      _photosFeedPath,
      queryParameters: {"page": page},
    );

    return ApiPage.fromJSON(page, response.data);
  }

  Future<ApiPage> searchPhotos(String query, {int page = 1}) async {
    final response = await _dio.get(
      _searchPhotoPath,
      queryParameters: {
        "query": query,
        "page": page,
      },
    );

    return ApiPage.fromJSON(page, response.data);
  }
}
