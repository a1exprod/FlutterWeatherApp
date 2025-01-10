import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class WeatherInformationOutput extends StatelessWidget {
  final String? cityName;
  final String? mainCondition;
  final int? temperature;
  final String weatherAnimationPath;

  const WeatherInformationOutput({
    Key? key,
    required this.cityName,
    required this.mainCondition,
    required this.temperature,
    required this.weatherAnimationPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/icons/location.svg',
          width: 50,
          height: 50,
          color: Colors.white70,
        ),
        SizedBox(height: 20), // Space between the location icon and city name
        Text(
          cityName ?? "loading city...",
          style: TextStyle(
            fontSize: 24,
            color: Color(0xFFB13A3A),
            fontFamily: 'F1-wide',
          ),
        ),
        Lottie.asset(weatherAnimationPath),
        Text(
          mainCondition ?? "",
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'F1-regular',
            color: Colors.white70,
          ),
        ),
        Text(
          temperature == null ? "" : '${temperature}°C',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontFamily: 'F1-bold-w',
          ),
        ),
      ],
    );
  }
}
