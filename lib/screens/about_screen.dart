import 'package:flutter/material.dart';
import 'dart:math'; 
import '../models/about_model.dart';

class AboutScreen extends StatelessWidget {
  final About about;

  static final List<String> reflexiones = [
    "La educación es el arma más poderosa que puedes usar para cambiar el mundo.",
    "El aprendizaje nunca agota la mente.",
    "La educación es el pasaporte hacia el futuro, el mañana pertenece a aquellos que se preparan para él hoy.",
    "La única persona educada es la que ha aprendido a aprender y cambiar.",
    "La educación no es preparación para la vida; la educación es la vida misma."
  ];

  final String randomReflexion;

  // Constructor
  AboutScreen({Key? key, required this.about})
      : randomReflexion = reflexiones[Random().nextInt(reflexiones.length)],
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900], // Color azul para el AppBar
        title: Text(
          'About ${about.nombre}',
          style: const TextStyle(color: Colors.white), // Letras blancas
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/fotominert.jpg'),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                '${about.nombre} ${about.apellido}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87, // Mismo color de texto que las anteriores
                ),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                'Matricula: ${about.matricula}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54, // Mismo color de texto que las anteriores
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Reflexión:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87, // Mismo color de texto que las anteriores
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                randomReflexion,
                style: const TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.black54, // Mismo color de texto que las anteriores
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
