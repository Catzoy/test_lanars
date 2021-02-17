import 'package:flutter/material.dart';
import 'package:test_lanars/api/data/api_photo.dart';

class PhotoPreviewTile extends StatelessWidget {
  final ApiPhoto image;

  const PhotoPreviewTile({Key key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          "/details",
          arguments: image,
        );
      },
      child: Hero(
        tag: image.id,
        child: Image.network(
          image.regularUrl,
          loadingBuilder: (context, child, progress) {
            return progress == null
                ? child
                : const Center(child: CircularProgressIndicator());
          },
          errorBuilder: (context, e, __) => ErrorWidget(e),
        ),
      ),
    );
  }
}
