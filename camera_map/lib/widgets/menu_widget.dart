import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class menubar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  menubar({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.photo_library),
          label: '갤러리',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.camera_alt),
          label: '사진 촬영',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: '지도',
        ),
      ],
      currentIndex: selectedIndex,
      onTap: onItemTapped,
    );
  }
}
