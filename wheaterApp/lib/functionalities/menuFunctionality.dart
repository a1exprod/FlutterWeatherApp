import 'package:flutter/material.dart';
import 'package:wheaterapp/pages/YourCurrentLocation.dart';
import '../pages/weatherPage.dart';
import '../pages/mapPage.dart';

class MenuFunctionality extends StatelessWidget {
  final int currentIndex;

  const MenuFunctionality({super.key, required this.currentIndex});

  void _onItemTapped(BuildContext context, int index) {
    if (index == currentIndex) return; // Verhindert erneutes Laden der gleichen Seite

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const WeatherPage()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Yourcurrentlocation()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MapPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.black87,
        currentIndex: currentIndex,
        onTap: (index) => _onItemTapped(context, index),
        iconSize: 30,
        selectedFontSize: 16,
        unselectedFontSize: 14,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud),
            label: 'Weather',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Your Location',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}