import 'package:flutter/material.dart';
import 'package:test_lanars/api/data/api_photo.dart';

class SinglePhoto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ApiPhoto image = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: InteractiveViewer(
              minScale: 0.5,
              maxScale: 4,
              child: Hero(
                tag: image.id,
                child: Image.network(
                  image.regularUrl,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
