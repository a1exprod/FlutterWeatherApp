import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../models/weatherModel.dart';
import 'package:http/http.dart' as http;

import 'package:latlong2/latlong.dart';



class WeatherService {
  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService(this.apiKey);


  Future<Weather> getWeather(String cityName) async {

    final response = await http
        .get(Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data - $BASE_URL?q=$cityName&appid=$apiKey');
    }

  }



  Future<LatLng> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    print(position.latitude);  // Breitengrad
    print(position.longitude); // Längengrad
    print(position.altitude);  // Höhe über dem Meeresspiegel
    print(position.speed);     // Geschwindigkeit in m/s
    print(position.heading);   // Bewegungsrichtung in Grad
    print(position.accuracy);  // Genauigkeit in Metern


    return LatLng(position.latitude, position.longitude);
  }

  Future<Position> getLocationDetails(String cityName) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    print(position.latitude);
    print(position.longitude);
    print(position.altitude);
    print(position.speed);
    print(position.heading);
    print(position.accuracy);

    return position;

  }


  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];

      String city = place.locality ?? "Unbekannt";
      String state = place.administrativeArea ?? "";
      String country = place.country ?? "";

      return "$city, $state, $country";
    }

    return "Unbekannter Ort";
  }


}