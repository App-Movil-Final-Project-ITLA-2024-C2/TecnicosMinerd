
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/school_model.dart';

Future<List<School>> fetchSchools({required String codigo}) async {
  final response = await http.get(Uri.parse('https://adamix.net/minerd/minerd/centros.php?regional=*'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    List<dynamic> data = jsonResponse['datos'];

    // Filtrar las escuelas por el código proporcionado
    List<School> filteredSchools = data
        .map((json) => School.fromJson(json))
        .where((school) => school.codigo == codigo)
        .toList();

    return filteredSchools;
  } else {
    throw Exception('Failed to load schools');
  }
}