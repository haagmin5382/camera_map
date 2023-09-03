import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ImageDetailScreen extends StatelessWidget {
  final String imagePath;

  ImageDetailScreen(this.imagePath);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Image Detail'),
      ),
      body: Center(
        child: Image.asset(
          imagePath,
          fit: BoxFit.contain, // 이미지를 화면에 맞게 확대
        ),
      ),
    );
  }
}
