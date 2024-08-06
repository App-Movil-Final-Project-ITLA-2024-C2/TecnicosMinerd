import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Horóscopo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HoroscopePage(),
    );
  }
}

class HoroscopePage extends StatelessWidget {
  const HoroscopePage({super.key});

  final List<String> signs = const [
    'Aries', 'Taurus', 'Gemini', 'Cancer', 'Leo', 'Virgo',
    'Libra', 'Scorpio', 'Sagittarius', 'Capricorn', 'Aquarius', 'Pisces'
  ];

  final Map<String, String> signImages = const {
    'Aries': 'assets/images/horoscope/aries.png',
    'Taurus': 'assets/images/horoscope/taurus.png',
    'Gemini': 'assets/images/horoscope/gemini.png',
    'Cancer': 'assets/images/horoscope/cancer.png',
    'Leo': 'assets/images/horoscope/leo.png',
    'Virgo': 'assets/images/horoscope/virgo.png',
    'Libra': 'assets/images/horoscope/libra.png',
    'Scorpio': 'assets/images/horoscope/scorpio.png',
    'Sagittarius': 'assets/images/horoscope/sagittarius.png',
    'Capricorn': 'assets/images/horoscope/capricorn.png',
    'Aquarius': 'assets/images/horoscope/aquarius.png',
    'Pisces': 'assets/images/horoscope/pisces.png',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Horóscopo'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: signs.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              String sign = signs[index].toLowerCase();
              String date = DateTime.now().toIso8601String().split('T')[0];
              String url = 'https://horoscope-app-api.vercel.app/api/v1/get-horoscope/daily?sign=$sign&day=$date';

              final response = await http.get(Uri.parse(url));

              if (response.statusCode == 200) {
                final data = json.decode(response.body);
                final horoscopeData = data['data']['horoscope_data'];
                final horoscopeDate = data['data']['date'];

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HoroscopeDetailPage(
                      sign: signs[index],
                      date: horoscopeDate,
                      horoscope: horoscopeData,
                      imageUrl: signImages[signs[index]]!,
                    ),
                  ),
                );
              } else {
                // Handle error
              }
            },
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    signs[index],
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 10),
                  ClipOval(
                    child: Image.asset(
                      signImages[signs[index]]!,
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class HoroscopeDetailPage extends StatelessWidget {
  final String sign;
  final String date;
  final String horoscope;
  final String imageUrl;

  const HoroscopeDetailPage({
    super.key,
    required this.sign,
    required this.date,
    required this.horoscope,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Horóscopo de $sign'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              date,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              horoscope,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Center(
              child: ClipOval(
                child: Image.asset(
                  imageUrl,
                  height: 250,
                  width: 250,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
