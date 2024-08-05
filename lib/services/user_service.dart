import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/registration_model.dart';
import '../models/user_model.dart';

class UserService {
  final String _baseUrl = 'https://adamix.net/minerd/def';

  Future<User?> login(String cedula, String clave) async {
    final url = Uri.parse('$_baseUrl/iniciar_sesion.php?cedula=$cedula&clave=$clave');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['exito']) {
          return User.fromJson(responseData['datos']);
        } else {
          throw Exception(responseData['mensaje']);
        }
      } else {
        throw Exception('Failed to log in');
      }
    } catch (error) {
      rethrow;
    }
  }
  
  Future<bool> registerUser(Registration registration) async {
    final url = Uri.parse('$_baseUrl/registro.php').replace(queryParameters: {
      'cedula': registration.cedula,
      'nombre': registration.nombre,
      'apellido': registration.apellido,
      'clave': registration.clave,
      'correo': registration.correo,
      'telefono': registration.telefono,
      'fecha_nacimiento': registration.fechaNacimiento,
    });

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
        throw Exception('Error en la respuesta del servidor: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error en la solicitud: $error');
    }
  }
}
