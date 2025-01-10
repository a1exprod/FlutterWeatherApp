
//API Structure
//http://api.geonames.org/searchJSON?q={cityName}&maxRows={int}&username={your_username}
//e.g. http://api.geonames.org/searchJSON?q=monaco&maxRows=10&username=as_mediaworks

import 'dart:convert';
import 'package:http/http.dart' as http;

class GeoNamesService {
  final String _username = "as_mediaworks";
  final String _baseUrl = "http://api.geonames.org/searchJSON";

  Future<List<Map<String, dynamic>>> searchCities(String query) async {
    final response = await http.get(Uri.parse(
      "$_baseUrl?q=$query&maxRows=10&username=$_username",
    ));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data.containsKey("status")) {
        throw Exception("API Error: ${data['status']['message']}");
      }

      return (data["geonames"] as List)
          .map((e) => {
        "name": e["name"],
        "country": e["countryName"],
        "latitude": e["lat"],
        "longitude": e["lng"],
      })
          .toList();
    } else {
      throw Exception("Failed to fetch data. Status Code: ${response.statusCode}");
    }
  }
}
