import 'dart:convert';
import 'package:http/http.dart' as http;

class LocationService {
  final String apiKey = 'f6a28a26fb36cb85c6121db78bfd9380'; 

  Future<String> getCityName(double latitude, double longitude) async {
    final String url = 'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['name'];
    } else {
      throw Exception('Failed to load location data');
    }
  }
}
