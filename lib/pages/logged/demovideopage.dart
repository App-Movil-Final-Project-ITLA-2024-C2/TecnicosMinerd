import 'package:flutter/material.dart';

class DemoVideoPage extends StatelessWidget {
  const DemoVideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Demostrativo'),
      ),
      body: const Center(
        child: Text('Pagina de Video Demostrativo'),
      ),
    );
  }
}
