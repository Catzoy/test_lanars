import 'package:test_lanars/api/data/api_photo.dart';

class ApiPage {
  final int pageNum;
  final List<ApiPhoto> photos;

  ApiPage(this.pageNum, this.photos);

  static ApiPage fromJSON(int pageNum, List list) {
    return ApiPage(
      pageNum,
      list.map(ApiPhoto.fromJSON).toList(growable: false),
    );
  }

  static ApiPage fromSearchPhotoJSON(int pageNum, dynamic json) {
    return fromJSON(pageNum, json["results"]);
  }
}
