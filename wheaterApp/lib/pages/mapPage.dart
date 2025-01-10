import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import '../widgets/map.dart';
import '../functionalities/menuFunctionality.dart';
import '../services/weatherService.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LatLng? _currentLocation;

  @override
  void initState() {
    super.initState();
    _loadCurrentLocation();
  }


  Future<void> _loadCurrentLocation() async {
    WeatherService weatherService = WeatherService("511480533d42d8260b374b507742e724");
    LatLng location = await weatherService.getCurrentLocation();
    setState(() {
      _currentLocation = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('World Map', style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: "F1-Black")),
        backgroundColor: Colors.blue,
        elevation: 4,
      ),
      body: _currentLocation == null
          ? Center(child: CircularProgressIndicator())
          : MapWidget(
        center: _currentLocation!,
        zoom: 14.0,
        userLocation: _currentLocation!,
      ),
      bottomNavigationBar: MenuFunctionality(currentIndex: 2),
    );
  }
}
