import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wheaterapp/services/weatherService.dart';
import '../functionalities/menuFunctionality.dart';
import 'package:wheaterapp/pages/mapPage.dart';

class Yourcurrentlocation extends StatefulWidget {
  const Yourcurrentlocation({super.key});

  @override
  State<Yourcurrentlocation> createState() => _YourcurrentlocationState();
}

class _YourcurrentlocationState extends State<Yourcurrentlocation> {
  Position? _position;
  String? _cityName;

  final WeatherService _weatherService = WeatherService('511480533d42d8260b374b507742e724');

  @override
  void initState() {
    super.initState();
    _fetchCurrentLocation();
    _fetchCurrentCity();
  }

  void _fetchCurrentLocation() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print("Standortdienste sind deaktiviert.");
        return;
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print("Standortberechtigung wurde abgelehnt.");
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        print("Standortberechtigungen sind dauerhaft deaktiviert.");
        return;
      }

      Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _position = pos;
      });

    } catch (e) {
      print("Fehler beim Abrufen der Standortdaten: $e");
    }
  }

  void _fetchCurrentCity() async {
    try {
      String city = await _weatherService.getCurrentCity();
      setState(() {
        _cityName = city;
      });
    } catch (e) {
      print("Fehler beim Abrufen der Stadt: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF131313),
      appBar: AppBar(
        title: Text("Your location", style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: "F1-Black")),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: _position == null
            ? CircularProgressIndicator(color: Colors.white)
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_cityName != null)
              Text("YOU ARE HERE:",
                  style: TextStyle(color: Colors.red, fontSize: 18, fontFamily: "F1-Wide")
              ),
            SizedBox(height: 10),
              Text("$_cityName",
                  style: TextStyle(color: Colors.white, fontSize: 22, fontFamily: "F1-Bold-w")
              ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MapPage()),
                );
              },
              child: Text("View on Map"),
            ),
            SizedBox(height: 60),
            Text("geodetic coordinates", style: TextStyle(color: Colors.red, fontSize: 20, fontFamily: "F1-Black")),
            SizedBox(height: 10),

            Text("Latitude:", style: _textStyle),
            Text("${_position!.latitude.toStringAsFixed(3)}", style: TextStyle(color: Colors.redAccent, fontSize: 16, fontFamily: "F1-Bold-w")),
            SizedBox(height: 8),

            Text("Longitude:", style: _textStyle),
            Text("${_position!.longitude.toStringAsFixed(3)}", style: TextStyle(color: Colors.redAccent, fontSize: 16, fontFamily: "F1-Bold-w")),
            SizedBox(height: 8),

            Text("Altitude:", style: _textStyle),
            Text("${_position!.altitude.toStringAsFixed(3)} m", style: TextStyle(color: Colors.redAccent, fontSize: 16, fontFamily: "F1-Bold-w")),
            SizedBox(height: 8),

            SizedBox(height: 60),
            Text("Accuracy: ±${_position!.accuracy.toStringAsFixed(0)} m", style: _textStyle),
            Text("Sea level: ${_position!.altitude.toStringAsFixed(0)} m", style: _textStyle),
          ],
        ),
      ),
      bottomNavigationBar: MenuFunctionality(currentIndex: 1),
    );
  }

  static const TextStyle _textStyle = TextStyle(
      color: Colors.white, fontSize: 16, fontFamily: 'F1-Regular'
  );
}
