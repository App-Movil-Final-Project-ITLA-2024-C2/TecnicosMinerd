import 'package:flutter/material.dart';
import 'package:tecnicos_minerd/services/incident_service.dart';
import '../../pages/incidents/incident_detail_page.dart';
import 'package:tecnicos_minerd/models/incident_model.dart';

class IncidentList extends StatefulWidget {
  const IncidentList({super.key});

  @override
  IncidentListState createState() => IncidentListState();
}

class IncidentListState extends State<IncidentList> {
  final _incidentService = IncidentService();
  late Future<List<Incident>> _incidents;

  void _loadData(){
    setState(() {
      _incidents = _incidentService.getIncidents();
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void refreshData() {
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List<Incident>>(
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
                          builder: (context) => IncidentDetailPage(incident: incident),
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
