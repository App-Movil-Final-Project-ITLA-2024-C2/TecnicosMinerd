import 'package:flutter/material.dart';
import '../models/visit_model.dart';

class VisitDetailPage extends StatelessWidget {
  final Visit visit;

  const VisitDetailPage({super.key, required this.visit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900], // Color azul para el AppBar
        title: const Text(
          'Detalles de la Visita',
          style: TextStyle(color: Colors.white), // Letras blancas
        ),
      ),
      body: Padding(
        padding:const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                visit.visitReason,
                style:const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
             const SizedBox(height: 20),
              _buildDetailRow('Director ID', visit.directorId),
              _buildDetailRow('Código de la Escuela', visit.schoolCode),
              _buildDetailRow('Fecha', visit.date),
              _buildDetailRow('Hora', visit.time),
              if (visit.photo != null) ...[
               const SizedBox(height: 20),
                const Text(
                  'Foto:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    visit.photo!,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
              if (visit.comment != null) ...[
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
                  padding:const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(visit.comment!),
                ),
              ],
              if (visit.audio != null) ...[
               const SizedBox(height: 20),
               const Text(
                  'Audio:',
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
                  child: Row(
                    children: [
                     const Icon(Icons.audiotrack),
                     const SizedBox(width: 10),
                      Text(visit.audio!),
                    ],
                  ),
                ),
              ],
             const SizedBox(height: 20),
              _buildDetailRow('Latitud', visit.latitude.toString()),
              _buildDetailRow('Longitud', visit.longitude.toString()),
            ],
          ),
        ),
      ),
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
