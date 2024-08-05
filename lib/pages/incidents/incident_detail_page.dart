import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:io';
import 'package:tecnicos_minerd/models/incident_model.dart';

class IncidentDetailPage extends StatefulWidget {
  final Incident incident;

  const IncidentDetailPage({super.key, required this.incident});

  @override
  IncidentDetailPageState createState() => IncidentDetailPageState();
}

class IncidentDetailPageState extends State<IncidentDetailPage> {
  final _player = AudioPlayer();
  bool _isPlaying = false;

  Future<void> _playPauseAudio() async {
    if (_isPlaying) {
      await _player.pause();
    } else {
      await _player.setSourceDeviceFile(widget.incident.audio!);
      await _player.resume();
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles de la Incidencia'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.incident.photo != null && widget.incident.photo!.isNotEmpty)
              Center(
                child: Image.file(
                  File(widget.incident.photo!),
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  Text(
                    widget.incident.title,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    widget.incident.date,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Centro Educativo:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 3),
            Center(
              child: Text(
                widget.incident.schoolName,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    const Text(
                      'Regional: ',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.incident.regional,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Distrito: ',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.incident.district,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 16, color: Colors.black, height: 1.6),
                    children: [
                      const TextSpan(
                        text: 'Descripción: ',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: widget.incident.description,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (widget.incident.audio != null && widget.incident.audio!.isNotEmpty)
              const SizedBox(height: 50),
              Center(
                child: ElevatedButton.icon(
                  icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                  label: Text(_isPlaying ? 'Pausar Audio' : 'Reproducir Audio'),
                  onPressed: _playPauseAudio,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50), // Full-width button
                    padding: const EdgeInsets.symmetric(vertical: 12.0), // Padding inside button
                    textStyle: const TextStyle(fontSize: 16), // Increase font size
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
