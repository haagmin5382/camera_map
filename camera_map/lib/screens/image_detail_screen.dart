import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ImageDetailScreen extends StatelessWidget {
  final String imagePath;

  const ImageDetailScreen(this.imagePath, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title:
            const Text('Image Detail', style: TextStyle(color: Colors.white)),
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
