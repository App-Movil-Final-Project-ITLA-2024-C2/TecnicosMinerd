import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../services/visit_service.dart';
import '../../models/visit_model.dart';

class VisitsMapPage extends StatefulWidget {
  final String token;

  const VisitsMapPage({super.key, required this.token});

  @override
   VisitsMapPageState createState() => VisitsMapPageState();
}

class VisitsMapPageState extends State<VisitsMapPage> {
  // ignore: unused_field
  late GoogleMapController _mapController;
  final Set<Marker> _markers = {};
  // ignore: unused_field
  late List<Visit> _visits;

  @override
  void initState() {
    super.initState();
    _fetchVisits();
  }

  Future<void> _fetchVisits() async {
    try {
      final visitService = VisitService();
      final visits = await visitService.getVisits(widget.token);
      setState(() {
        _visits = visits;
        _markers.clear();
        for (var visit in visits) {
          final position = LatLng(double.parse(visit.latitud), double.parse(visit.longitud));
          _markers.add(
            Marker(
              markerId: MarkerId(visit.situacionId.toString()),
              position: position,
              infoWindow: InfoWindow(
                title: visit.motivo,
                snippet: '${visit.fecha},  ${visit.hora}',
                onTap: () => _showVisitDetails(visit),
              ),
            ),
          );
        }
      });
    } catch (e) {
    }
  }

  void _showVisitDetails(Visit visit) async {
    try {
      final visitService = VisitService();
      final visitDetails = await visitService.getVisitDetail(widget.token, visit.situacionId.toString());
      if(mounted){
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(visitDetails.motivo),
            content: Text(visitDetails.comentario),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if(mounted){
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: const Text('No se pudo obtener los detalles de la visita.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa de Visitas'),
      ),
      body: GoogleMap(
        onMapCreated: (controller) {
          _mapController = controller;
        },
        initialCameraPosition: const CameraPosition(
          target: LatLng(0, 0),
          zoom: 2,
        ),
        markers: _markers,
      ),
    );
  }
}