import 'dart:io';
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

  void _loadData() {
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
    return FutureBuilder<List<Incident>>(
      future: _incidents,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Card(
                color: Colors.grey[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'No hay incidentes',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return ListView.separated(
            itemCount: snapshot.data!.length,
            separatorBuilder: (context, index) => const Divider(height: 1, color: Colors.grey),
            itemBuilder: (context, index) {
              final incident = snapshot.data![index];
              return ListTile(
                contentPadding: const EdgeInsets.all(8),
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: incident.photo != null ? FileImage(File(incident.photo!)) : null,
                  child: incident.photo == null
                      ? const Icon(Icons.image, size: 30, color: Colors.grey)
                      : null,
                ),
                title: Text(
                  incident.title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                subtitle: Text(
                  incident.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                tileColor: Colors.grey[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
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
    );
  }
}
