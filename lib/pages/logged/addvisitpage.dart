import 'package:flutter/material.dart';

class AddVisitPage extends StatelessWidget {
  const AddVisitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Añadir Visitas'),
      ),
      body: const Center(
        child: Text('Pagina de añadir Visitas'),
      ),
    );
  }
}
