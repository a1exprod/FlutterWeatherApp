# WeatherApp

This **Flutter-based weather app** provides real-time weather data, precise location tracking, and an intuitive user experience with smooth animations.

## Features

- **Real-Time Weather Data**: Fetches up-to-date weather conditions using the OpenWeather API.
- **GPS-Based Location Tracking**: Automatically detects your current location.
- **Detailed Location Information**: Displays city, region, and country name along with precise coordinates (latitude, longitude, altitude).
- **Interactive Map**: Shows your current location on a map.
- **Fuzzy Search**: Quickly search for any city worldwide using the Fuzzy Search API.
- **Lottie Animations**: Beautiful animated weather icons.
- **Splash Screen**: Custom splash screen for a polished app launch experience.
- **Custom App Icon**: Unique branding for the application.


## Technologies Used

- **Flutter** (Dart)
- **OpenWeather API** for weather data
- **Geolocator & Geocoding** for GPS tracking and location details
- **Fuzzy Search API** for searching cities
- **Lottie** for animations
- **Google Maps / OpenStreetMap** for the interactive map

## Installation

1. **Clone the repository**:
   ```sh
   git clone https://github.com/a1exprod/weatherapp.git
   cd weatherapp
   ```

2. **Install dependencies**:
   ```sh
   flutter pub get
   ```

3. **Run the app**:
   ```sh
   flutter run
   ```

## Configuration

- Obtain an **OpenWeather API key** and add it to `WeatherService.dart`:
  ```dart
  final WeatherService _weatherService = WeatherService('YOUR_API_KEY_HERE');
  ```
- Ensure that location permissions are granted in your app settings.


## Future Improvements

- Implement a **dark mode**
- Enhance **UI design with additional animations**
- Improve **performance optimizations**

## License

This project is open-source and available under the [MIT License](LICENSE).

## Contact
For any questions or collaboration, reach out via alexander.schnabl@outlook.com or check out my Portfolio-Homepage: https://alexander-schnabl.myportfolio.com/flutter-weather-app .
