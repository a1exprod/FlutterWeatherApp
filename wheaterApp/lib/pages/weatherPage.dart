import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:wheaterapp/models/weatherModel.dart';
import 'package:wheaterapp/services/weatherService.dart';
import 'package:wheaterapp/services/fuzzySearch.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../functionalities/menuFunctionality.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  final _weatherService = WeatherService('511480533d42d8260b374b507742e724');
  Weather? _weather;



  TextEditingController _searchCityController = TextEditingController();

  // GeoNamesService
  final GeoNamesService _geoNamesService = GeoNamesService();
  List<Map<String, dynamic>> _citySuggestions = [];

  String? _errorNoCityFound = "";






  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();


    try {
      final weather = await _weatherService.getWeather(cityName);
      if (weather != null) {
        setState(() {
          _weather = weather;
        });
      } else {
        setState(() {
          _errorNoCityFound = 'Kein Wetterdaten verfügbar';
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        _errorNoCityFound = 'Fehler beim Abrufen der Wetterdaten';
      });
    }
  }

  _fetchOtherWeather(String cityName) async {
    try {
      final weather = await _weatherService.getWeather(cityName);
      if (weather != null) {
        setState(() {
          _weather = weather;
          _errorNoCityFound = 'hereee'; // Lösche die Fehlermeldung, wenn Wetterdaten vorhanden sind
        });
      } else {
        setState(() {
          _errorNoCityFound = 'Stadt nicht gefunden!';
        });
      }
    } catch (e) {
      setState(() {
        _errorNoCityFound = 'Stadt nicht gefunden!';
      });
      print(e);
    }
  }







  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny_animation.json'; //default

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
        return 'assets/cloud_animation.json';
      case 'mist':
        return 'assets/mist_animation.json';
      case 'smoke':
        return 'assets/mist_animation.json';
      case 'haze':
        return 'assets/smoke_animation.json';
      case 'dust':
        return 'assets/mist_animation.json';
      case 'fog':
        return 'assets/smoke_animation.json';
      case 'rain':
        return 'assets/rainy_animation.json';
      case 'drizzle':
        return 'assets/drizzle_animation.json';
      case 'shower rain':
        return 'assets/rainy_animation.json';
      case 'thunderstorm':
        return 'assets/thunderstorm_animation.json';
      case 'clear':
        return 'assets/sunny_animation.json';
      default:
        return 'assets/sunny_animation.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();

  }


  void _onSearchChanged(String query) async {
    if (query.isNotEmpty) {
      try {
        final results = await _geoNamesService.searchCities(query);
        setState(() {
          _citySuggestions = results;
        });
      } catch (e) {
        print("Fehler: $e");
      }
    } else {
      setState(() {
        _citySuggestions = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF131313),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppBar(
                title: Text('AS-Weather', style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: "F1-Black")),
                backgroundColor: Colors.blue, // Hier kannst du die Farbe der AppBar ändern
                elevation: 4, // Fügt einen Schatten hinzu (optional)
              ),
              SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Container(
                    width: 200,
                    child: TextField(
                      controller: _searchCityController,
                      decoration: InputDecoration(
                        hintText: 'search city',
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(
                          color: Colors.white38,
                          fontFamily: 'F1-regular',
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'F1-regular',
                      ),
                      onChanged: _onSearchChanged, // Auslösen der Suche bei Eingabeänderung
                    ),
                  ),
                  SizedBox(width: 10),
                  // ElevatedButton für den Such-Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      String cityName = _searchCityController.text;
                      if (cityName.isNotEmpty) {
                        _fetchOtherWeather(cityName);
                      }
                    },
                    child: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              if (_citySuggestions.isNotEmpty)
                Container(
                  height: 200,
                  child: ListView.builder(
                    itemCount: _citySuggestions.length,
                    itemBuilder: (context, index) {
                      final city = _citySuggestions[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: Offset(0, 4),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: ListTile(
                          title: Text(
                            city["name"],
                            style: TextStyle(color: Colors.black),
                          ),
                          subtitle: city["country"] != null && city["country"].isNotEmpty
                              ? Text(
                            city["country"],
                            style: TextStyle(color: Colors.black54),
                          )
                              : null,
                          onTap: () {
                            _fetchOtherWeather(city["name"]);
                            setState(() {
                              _citySuggestions = [];
                              _searchCityController.text = city["name"];
                            });
                          },
                        ),
                      );


                    },
                  ),
                ),

              _weather == null
                  ? CircularProgressIndicator(
                color: Colors.white,
              ) // Ladeanzeige, wenn keine Wetterdaten vorhanden
                  : Column(
                children: [

                  SvgPicture.asset(
                    'assets/icons/location.svg',
                    width: 50,
                    height: 50,
                    color: Colors.white70,
                  ),

                  Text(
                    _weather?.cityName ?? "Lädt Stadt...",
                    style: TextStyle(
                      fontSize: 24,
                      color: Color(0xFFB13A3A),
                      fontFamily: 'F1-wide',
                    ),
                  ),

                  Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

                  Text(
                    _weather?.mainCondition ?? "",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'F1-regular',
                      color: Colors.white70,
                    ),
                  ),

                  Text(
                    _weather == null
                        ? ""
                        : '${_weather?.temperature.round()}°C',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontFamily: 'F1-bold-w',
                    ),
                  ),
                  SizedBox(height: 60),

                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MenuFunctionality(currentIndex: 0),
    );
  }
}
