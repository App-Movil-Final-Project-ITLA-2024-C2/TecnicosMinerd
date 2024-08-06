import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../models/visit_model.dart';
import '../../services/visit_service.dart';
import 'dart:io';

import '../../utils/get_token_util.dart';
import '../../widgets/mapwidget.dart';

class VisitDetailPage extends StatefulWidget {
  final String situacionId;

  const VisitDetailPage({super.key, required this.situacionId});

  @override
  State<VisitDetailPage> createState() => _VisitDetailPageState();
}

class _VisitDetailPageState extends State<VisitDetailPage> {
  final VisitService visitService = VisitService();
  final AudioPlayer _player = AudioPlayer();
  bool _isPlaying = false;

  Future<void> _playPauseAudio(String audioPath) async {
    final exists = await _fileExists(audioPath);
    if (!exists) {
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('El archivo de audio no existe'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
        return;
      }
    }

    try {
      if (_isPlaying) {
        await _player.pause();
      } else {
        await _player.setSourceDeviceFile(audioPath);
        await _player.resume();
      }

      setState(() {
        _isPlaying = !_isPlaying;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error al reproducir el audio'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }

  Future<bool> _fileExists(String path) async {
    return File(path).exists();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: TokenUtil.getToken(),
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
            future: visitService.getVisitDetail(token, widget.situacionId),
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
                          Center(
                            child: Text(
                              visit.motivo,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          _buildDetailRow('Director ID', visit.cedulaDirector),
                          _buildDetailRow('Escuela ID', visit.codigoCentro),
                          _buildDetailRow('Fecha y Hora', '${visit.fecha}, ${visit.hora}'),
                          if (visit.comentario.isNotEmpty) ...[
                            const SizedBox(height: 5),
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
                          if (visit.fotoEvidencia.isNotEmpty)
                            FutureBuilder<bool>(
                              future: _fileExists(visit.fotoEvidencia),
                              builder: (context, fileSnapshot) {
                                if (fileSnapshot.connectionState == ConnectionState.waiting) {
                                  return const Center(child: CircularProgressIndicator());
                                } else if (fileSnapshot.hasError || !fileSnapshot.data!) {
                                  return const SizedBox();
                                } else {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 20),
                                      const Text(
                                        'Evidencia:',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Center(
                                        child: Image.file(
                                          File(visit.fotoEvidencia),
                                          width: double.infinity,
                                          height: 200,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              },
                            ),
                          if (visit.notaVoz.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                Center(
                                  child: ElevatedButton.icon(
                                    icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                                    label: Text(_isPlaying ? 'Pausar Audio' : 'Reproducir Audio'),
                                    onPressed: () => _playPauseAudio(visit.notaVoz),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue[900],
                                      minimumSize: const Size(double.infinity, 50), // Ancho máximo
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          const SizedBox(height: 20),
                          const Text(
                            'Ubicación:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          MapWidget(
                            latitude: double.tryParse(visit.latitud) ?? 0,
                            longitude: double.tryParse(visit.longitud) ?? 0,
                          ),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
