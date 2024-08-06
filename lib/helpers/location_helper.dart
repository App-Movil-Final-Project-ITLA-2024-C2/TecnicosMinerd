import 'package:geolocator/geolocator.dart';

class LocationHelper {
  static Future<Position> getCurrentLocation() async {
    try {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      print('Exception caught in LocationHelper: $e');
      throw Exception('Failed to get location: $e');
    }
  }
}
