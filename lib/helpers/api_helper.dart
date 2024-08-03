import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiHelper {
  final String _baseUrl;
  final Map<String, String> _headers;

  ApiHelper(this._baseUrl) : _headers = {'Content-Type': 'application/json'};

  Future<http.Response> post(String endpoint, {Map<String, dynamic>? body}) async {
    var uri = Uri.parse("$_baseUrl$endpoint");
    return await http.post(uri, headers: _headers, body: jsonEncode(body));
  }

  Future<http.Response> get(String endpoint) async {
    var uri = Uri.parse("$_baseUrl$endpoint");
    return await http.get(uri);
  }

  Future<http.Response> put(String endpoint, {Map<String, dynamic>? body}) async {
    var uri = Uri.parse("$_baseUrl$endpoint");
    return await http.put(uri, headers: _headers, body: jsonEncode(body));
  }

  Future<http.Response> multipartPost(String endpoint, Map<String, String> fields, List<http.MultipartFile> files) async {
    var uri = Uri.parse("$_baseUrl$endpoint");
    var request = http.MultipartRequest("POST", uri);
    request.fields.addAll(fields);
    request.files.addAll(files);
    return await request.send().then((response) => http.Response.fromStream(response));
  }
}
