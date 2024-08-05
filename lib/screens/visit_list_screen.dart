import 'package:flutter/material.dart';
import '../models/visit_model.dart';
import 'visit_detail_screen.dart'; // Asegúrate de importar la página de detalles

class VisitList extends StatelessWidget {
  final List<Visit> visits = [
    Visit(
      id: 1,
      directorId: 'D123',
      schoolCode: 'S001',
      visitReason: 'Inspection',
      comment: 'All good',
      photo: 'assets/Escuela.jpeg', // Ruta de la imagen estática
      latitude: 18.4861,
      longitude: -69.9312,
      date: '2023-08-01',
      time: '10:00 AM',
    ),
    Visit(
      id: 2,
      directorId: 'D124',
      schoolCode: 'S002',
      visitReason: 'Maintenance',
      comment: 'Need repairs',
      photo: 'assets/Escuela.jpeg', // Ruta de la imagen estática
      latitude: 18.4861,
      longitude: -69.9312,
      date: '2023-08-02',
      time: '11:00 AM',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.blue[900],
            child: const Row(
              children: [
                SizedBox(width: 10),
                Text(
                  'Lista de Visitas',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: visits.length,
              itemBuilder: (context, index) {
                final visit = visits[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    title: Text(
                      visit.visitReason,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('School Code: ${visit.schoolCode}'),
                        Text('Date: ${visit.date}'),
                        Text('Time: ${visit.time}'),
                      ],
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VisitDetailPage(visit: visit),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
