import 'package:flutter/material.dart';

class HoroscopePage extends StatelessWidget {
  const HoroscopePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Horoscopo'),
      ),
      body: const Center(
        child: Text('Pagina de Horoscopo'),
      ),
    );
  }
}
