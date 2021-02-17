class ApiPhoto {
  final String id;
  final String regularUrl;
  final String thumbUrl;

  ApiPhoto(
    this.id,
    this.regularUrl,
    this.thumbUrl,
  );

  static ApiPhoto fromJSON(json) {
    final Map urls = json["urls"];
    return ApiPhoto(
      json["id"],
      urls["regular"],
      urls["thumb"],
    );
  }
}
