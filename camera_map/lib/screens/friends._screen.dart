import 'package:camera_map/screens/image_detail_screen.dart';
import 'package:flutter/material.dart';

class GalleryScreen extends StatelessWidget {
  final List<String> images = [
    "assets/sky.jpg",
    "assets/mountain.jpg",
    "assets/palace.jpg",
    // 다른 이미지 경로들을 추가하세요.
  ];

  GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: const Text('Friends', style: TextStyle(color: Colors.white)),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 열의 수
        ),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // 이미지를 확대하여 표시하는 화면으로 이동
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImageDetailScreen(images[index]),
                ),
              );
            },
            child: Image.asset(
              images[index],
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
