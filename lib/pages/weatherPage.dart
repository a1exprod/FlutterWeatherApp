//APP UI

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wheaterapp/models/weatherModel.dart';
import 'package:wheaterapp/services/weatherService.dart';



class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}







class _WeatherPageState extends State<WeatherPage> {



  //api key
  final _weatherService = WeatherService('511480533d42d8260b374b507742e724');
  Weather? _weather;


  //fetch weather
  _fetchWeather() async {
    //get the current city
    String cityName = await _weatherService.getCurrentCity();

    //get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }
    //any errors
    catch (e) {
      print(e);
    }
  }

  //weather animations
  String getWeatherAnimation(String? mainCondition) {
    if(mainCondition == null) return 'assets/sunny_animation.json'; //default

    switch(mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud_animation.json';
      case 'rain':
      case 'drizzle':
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

  //init state
  @override
  void initState() {
    //TODO: implement initState
    super.initState();

    //fetch weather on startup
    _fetchWeather();
  }


//DISPLAY ON UI

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //city Name
            Text(_weather?.cityName ?? "loading city..."),

            //animation
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

            //weather Condition
            Text(_weather?.mainCondition ?? ""),
            //temperatur
            Text(_weather == null ? "" : '${_weather?.temperature.round()}°C'),
          ],
        ),
      )
    );
  }
}
