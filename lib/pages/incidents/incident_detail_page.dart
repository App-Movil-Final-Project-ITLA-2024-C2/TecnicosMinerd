import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:io';
import 'package:tecnicos_minerd/models/incident_model.dart';

class IncidentDetailPage extends StatelessWidget {
  final Incident incident;

  const IncidentDetailPage({super.key, required this.incident});

  @override
  Widget build(BuildContext context) {
    final player = AudioPlayer();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles de la Incidencia'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Título: ${incident.title}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('Centro Educativo: ${incident.schoolName}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text('Regional: ${incident.regional}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text('Distrito: ${incident.district}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text('Fecha: ${incident.date}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text('Descripción: ${incident.description}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            if (incident.photo != null && incident.photo!.isNotEmpty)
              Image.file(File(incident.photo!)),
            const SizedBox(height: 20),
            if (incident.audio != null && incident.audio!.isNotEmpty)
              ElevatedButton(
                onPressed: () async {
                  await player.setSourceDeviceFile(incident.audio!);
                  player.resume();
                },
                child: const Text('Reproducir Audio'),
              ),
          ],
        ),
      ),
    );
  }
}
