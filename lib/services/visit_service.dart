import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/visit_model.dart';

class VisitService {
  final String _baseUrl = 'https://adamix.net/minerd/def';

  Future<bool> registerVisit(Visit visit) async {
    final url = Uri.parse('https://adamix.net/minerd/minerd/registrar_visita.php').replace(queryParameters: visit.toJson());

    try {
      final response = await http.get(url, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['exito']) {
          return true;
        } else {
          throw Exception(responseData['mensaje']);
        }
      } else {
        throw Exception('Error al registrar visita...');
      }
    } catch (error) {
      throw Exception('Error en la solicitud: $error');
    }
  }

  Future<List<Visit>> getVisits(String token) async {
    final url = Uri.parse('$_baseUrl/situaciones.php').replace(queryParameters: {'token': token});

    try {
      final response = await http.get(url, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['exito']) {
          List<Visit> visits = (responseData['datos'] as List)
              .map((data) => Visit.fromJson(data))
              .toList();
          visits = visits.reversed.toList();
          return visits;
        } else {
          throw Exception(responseData['mensaje']);
        }
      } else {
        throw Exception('Error al consultar visitas');
      }
    } catch (error) {
      throw Exception('Error en la solicitud: $error');
    }
  }

  Future<Visit> getVisitDetail(String token, String situacionId) async {
    final url = Uri.parse('$_baseUrl/situacion.php').replace(queryParameters: {
      'token': token,
      'situacion_id': situacionId.toString(),
    });

    try {
      final response = await http.get(url, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['exito']) {
          return Visit.fromJson(responseData['datos']);
        } else {
          throw Exception(responseData['mensaje']);
        }
      } else {
        throw Exception('Error al consultar los detalles de la visita');
      }
    } catch (error) {
      throw Exception('Error en la solicitud: $error');
    }
  }
}
