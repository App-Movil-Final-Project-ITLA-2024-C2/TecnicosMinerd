import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/school_model.dart';

class SchoolService {
  Future<School?> schoolByCode({required String codigo}) async {
    final response = await http.get(Uri.parse('https://adamix.net/minerd/minerd/centros.php?regional=*'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      List<dynamic> data = jsonResponse['datos'];

      final schoolMap = { for (var json in data) School.fromJson(json).codigo: School.fromJson(json) };
      
      return schoolMap[codigo]; // Buscar la escuela por código
    } else {
      throw Exception('Failed to load schools');
    }
  }
}
