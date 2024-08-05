import 'package:flutter/material.dart';

class VisitsMapsPage extends StatelessWidget {
  const VisitsMapsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa de Visitas'),
      ),
      body: const Center(
        child: Text('Mapa de Visitas'),
      ),
    );
  }
}
