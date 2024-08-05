import 'package:flutter/material.dart';

class DeletePage extends StatelessWidget {
  const DeletePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eliminar'),
      ),
      body: const Center(
        child: Text('Página de Eliminar'),
      ),
    );
  }
}