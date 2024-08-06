import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatefulWidget {
  final double latitude;
  final double longitude;

  const MapWidget({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  MapWidgetState createState() => MapWidgetState();
}

class MapWidgetState extends State<MapWidget> {
  String _address = '';

  @override
  void initState() {
    super.initState();
    _getAddress();
  }

  Future<void> _getAddress() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(widget.latitude, widget.longitude);
      if (placemarks.isNotEmpty) {
        final Placemark placemark = placemarks.first;
        setState(() {
          _address = '${placemark.country}, ${placemark.locality}, ${placemark.street}';
        });
      }
    } catch (e) {
      setState(() {
        _address = 'No se pudo obtener la dirección';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final marker = Marker(
      markerId: const MarkerId('Location'),
      position: LatLng(widget.latitude, widget.longitude),
      infoWindow: InfoWindow(
        title: 'Ubicación',
        snippet: _address,
      ),
    );

    return SizedBox(
      height: 300, // Ajusta el tamaño del mapa según sea necesario
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.latitude, widget.longitude),
          zoom: 12,
        ),
        markers: {marker},
        onMapCreated: (GoogleMapController controller) {},
      ),
    );
  }
}
