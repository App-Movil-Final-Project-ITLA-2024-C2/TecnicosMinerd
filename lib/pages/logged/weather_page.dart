import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart'; 
import '../../services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  WeatherPageState createState() => WeatherPageState();
}

class WeatherPageState extends State<WeatherPage> {
  String _weatherInfo = 'Cargando clima...';
  bool _isLoading = true;
  String _icon = '';

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    setState(() {
      _isLoading = true;
    });

    try {

      PermissionStatus permission = await Permission.location.status;
      if (!permission.isGranted) {
        permission = await Permission.location.request();
        if (!permission.isGranted) {
          throw Exception('Permisos de ubicación denegados');
        }
      }

      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      WeatherService weatherService = WeatherService();
      Map<String, dynamic> weatherData = await weatherService.getWeather(position.latitude, position.longitude);

      setState(() {
        _weatherInfo = 'Temperatura: ${weatherData['main']['temp']}°C\n'
                       'Clima: ${weatherData['weather'][0]['description']}\n'
                       'Ubicación: ${weatherData['name']}';
        _icon = 'http://openweathermap.org/img/wn/${weatherData['weather'][0]['icon']}@2x.png';
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _weatherInfo = 'No se pudo obtener la información del clima: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información del Clima'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Información del Clima',
                          style: TextStyle(
                            fontSize: 24,  
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey[800],
                          ),
                        ),
                        const SizedBox(height: 16),
                        _icon.isNotEmpty
                          ? Image.network(_icon, height: 100)
                          : const SizedBox.shrink(),
                        const SizedBox(height: 16),
                        Text(
                          _weatherInfo,
                          style: TextStyle(
                            fontSize: 18, 
                            color: Colors.blueGrey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
