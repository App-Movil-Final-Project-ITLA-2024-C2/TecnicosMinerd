import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = 'f6a28a26fb36cb85c6121db78bfd9380';

  Future<Map<String, dynamic>> getWeather(double latitude, double longitude) async {
    final String url = 'https://api.openweathermap.org/data/2.5/weather'
                        '?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric&lang=es';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
