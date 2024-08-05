import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/visit_model.dart';
import '../../services/visit_service.dart';

class VisitDetailPage extends StatelessWidget {
  final String situacionId;
  final VisitService visitService = VisitService(); // Instancia del servicio

   VisitDetailPage({super.key, required this.situacionId});

  Future<String?> _loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');
    if (userJson != null) {
      Map<String, dynamic> userMap = jsonDecode(userJson);
      return userMap['token'];
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _loadToken(),
      builder: (context, tokenSnapshot) {
        if (tokenSnapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue[900],
              title: const Text('Detalles de la Visita', style: TextStyle(color: Colors.white)),
            ),
            body: const Center(child: CircularProgressIndicator()),
          );
        } else if (tokenSnapshot.hasError || tokenSnapshot.data == null) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue[900],
              title: const Text('Detalles de la Visita', style: TextStyle(color: Colors.white)),
            ),
            body: Center(child: Text('Error al cargar el token: ${tokenSnapshot.error}')),
          );
        } else {
          final token = tokenSnapshot.data!;
          return FutureBuilder<Visit>(
            future: visitService.getVisitDetail(token, situacionId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.blue[900],
                    title: const Text('Detalles de la Visita', style: TextStyle(color: Colors.white)),
                  ),
                  body: const Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasError) {
                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.blue[900],
                    title: const Text('Detalles de la Visita', style: TextStyle(color: Colors.white)),
                  ),
                  body: Center(child: Text('Error: ${snapshot.error}')),
                );
              } else if (!snapshot.hasData) {
                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.blue[900],
                    title: const Text('Detalles de la Visita', style: TextStyle(color: Colors.white)),
                  ),
                  body: const Center(child: Text('No hay detalles disponibles')),
                );
              } else {
                final visit = snapshot.data!;
                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.blue[900],
                    title: const Text('Detalles de la Visita', style: TextStyle(color: Colors.white)),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            visit.motivo,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildDetailRow('Director ID', visit.cedulaDirector),
                          _buildDetailRow('Código de la Escuela', visit.codigoCentro),
                          _buildDetailRow('Fecha', visit.fecha),
                          _buildDetailRow('Hora', visit.hora),
                          if (visit.fotoEvidencia.isNotEmpty) ...[
                            const SizedBox(height: 20),
                            const Text(
                              'Foto:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            /*ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                visit.fotoEvidencia, // Usa Image.network para cargar imágenes desde la URL
                                fit: BoxFit.cover,
                              ),
                            ),*/
                          ],
                          if (visit.comentario.isNotEmpty) ...[
                            const SizedBox(height: 20),
                            const Text(
                              'Comentario:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Text(visit.comentario),
                            ),
                          ],
                          if (visit.notaVoz.isNotEmpty) ...[
                            const SizedBox(height: 20),
                            const Text(
                              'Audio:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            /*
                            Container(
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.audiotrack),
                                  const SizedBox(width: 10),
                                  Text(
                                    visit.notaVoz,
                                    style: const TextStyle(
                                      overflow: TextOverflow.fade
                                      ),
                                    ),
                                ],
                              ),
                            ),*/
                          ],
                          const SizedBox(height: 20),
                          _buildDetailRow('Latitud', visit.latitud),
                          _buildDetailRow('Longitud', visit.longitud),
                        ],
                      ),
                    ),
                  ),
                );
              }
            },
          );
        }
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
