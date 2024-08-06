import 'package:http/http.dart' as http;
import 'dart:convert';

class HoroscopeService {
  Future<Map<String, dynamic>> fetchHoroscope(String sign) async {
    String date = DateTime.now().toIso8601String().split('T')[0];
    String url = 'https://horoscope-app-api.vercel.app/api/v1/get-horoscope/daily?sign=$sign&day=$date';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return {
        'horoscope': data['data']['horoscope_data'],
        'date': data['data']['date']
      };
    } else {
      throw Exception('Error al obtener el horóscopo');
    }
  }
}
