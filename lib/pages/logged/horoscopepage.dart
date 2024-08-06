import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../services/horoscope_service.dart';
import '../../utils/zodiac_util.dart';

class HoroscopePage extends StatefulWidget {
  const HoroscopePage({super.key});

  @override
  HoroscopePageState createState() => HoroscopePageState();
}

class HoroscopePageState extends State<HoroscopePage> {
  String? _userSign;
  String? _horoscope;
  String? _horoscopeDate;

  @override
  void initState() {
    super.initState();
    _fetchUserHoroscope();
  }

  Future<void> _fetchUserHoroscope() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userJson = prefs.getString('user');
      if (userJson != null) {
        Map<String, dynamic> userMap = jsonDecode(userJson);
        DateTime birthDate = DateTime.parse(userMap['fecha_nacimiento']);
        _userSign = ZodiacUtil.getZodiacSign(birthDate);

        if (_userSign != null) {
          HoroscopeService horoscopeService = HoroscopeService();
          var data = await horoscopeService.fetchHoroscope(_userSign!.toLowerCase());
          setState(() {
            _horoscope = data['horoscope'];
            _horoscopeDate = data['date'];
          });
        }
      }
    } catch (e) {
      setState(() {
        _horoscope = 'Error al obtener el horóscopo';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Horospoco del $_horoscopeDate'
        ),
      ),
      body: _horoscope == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  Center(
                    child: Text(
                      'Horóscopo de $_userSign',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Center(
                    child: Text(
                      _horoscope ?? '',
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Center(
                    child: ClipOval(
                      child: Image.asset(
                        ZodiacUtil.signImages[_userSign!]!,
                        height: 200,
                        width: 200,
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
