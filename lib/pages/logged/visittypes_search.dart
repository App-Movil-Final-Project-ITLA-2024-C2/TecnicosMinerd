import 'package:flutter/material.dart';

class VisitTypesPage extends StatelessWidget {
  const VisitTypesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tipos de Visitas'),
      ),
      body: const Center(
        child: Text('Tipos de Visitas'),
      ),
    );
  }
}
