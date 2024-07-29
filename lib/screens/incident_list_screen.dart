import 'package:flutter/material.dart';
import 'package:tecnicos_minerd/services/incident_service.dart';
import 'incident_detail_screen.dart';
import 'package:tecnicos_minerd/models/incident_model.dart';

class IncidentListScreen extends StatefulWidget {
  @override
  _IncidentListScreenState createState() => _IncidentListScreenState();
}

class _IncidentListScreenState extends State<IncidentListScreen> {
  final _incidentService = IncidentService();
  late Future<List<Incident>> _incidents;

  @override
  void initState() {
    super.initState();
    _incidents = _incidentService.getIncidents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Incidencias'),
      ),
      body: FutureBuilder<List<Incident>>(
        future: _incidents,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay incidencias'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final incident = snapshot.data![index];
                return ListTile(
                  title: Text(incident.title),
                  subtitle: Text(incident.description),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => IncidentDetailScreen(incident: incident),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
