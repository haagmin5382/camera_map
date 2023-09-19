import 'package:flutter/material.dart';

class menubar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const menubar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: '친구 목록',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: '메시지',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: '지도',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: '내 정보',
        )
      ],
      currentIndex: selectedIndex,
      onTap: onItemTapped,
    );
  }
}
