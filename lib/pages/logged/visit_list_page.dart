import 'package:flutter/material.dart';
import '../../models/visit_model.dart';
import '../../services/visit_service.dart';
import '../../utils/get_token_util.dart'; 

class VisitListPage extends StatefulWidget {
  @override
  _VisitListPageState createState() => _VisitListPageState();
}

class _VisitListPageState extends State<VisitListPage> {
  final VisitService _visitService = VisitService();
  List<Visit> _visits = [];
  String? _token;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    _token = await TokenUtil.getToken(); 
    if (_token != null) {
      _loadVisits();
    }
  }

  Future<void> _loadVisits() async {
    if (_token != null) {
      try {
        final visits = await _visitService.getVisits(_token!);
        setState(() {
          _visits = visits;
        });
      } catch (error) {

        print('Error al cargar visitas: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visitas Registradas'),
      ),
      body: _token == null
          ? const Center(child: CircularProgressIndicator())
          : _visits.isEmpty
              ? const Center(child: Text('No hay visitas registradas.'))
              : ListView.builder(
                  itemCount: _visits.length,
                  itemBuilder: (context, index) {
                    final visit = _visits[index];
                    return ListTile(
                      title: Text('Motivo: ${visit.motivo}'),
                      subtitle: Text('Fecha: ${visit.fecha} - Hora: ${visit.hora}'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VisitDetailPage(visit: visit),
                          ),
                        );
                      },
                    );
                  },
                ),
    );
  }
}

class VisitDetailPage extends StatelessWidget {
  final Visit visit;

  VisitDetailPage({required this.visit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de Visita'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Cedula Director: ${visit.cedulaDirector}'),
            Text('Código Centro: ${visit.codigoCentro}'),
            Text('Motivo: ${visit.motivo}'),
            Text('Comentario: ${visit.comentario}'),
            Text('Nota de Voz: ${visit.notaVoz}'),
            Text('Latitud: ${visit.latitud}'),
            Text('Longitud: ${visit.longitud}'),
            Text('Fecha: ${visit.fecha}'),
            Text('Hora: ${visit.hora}'),
          ],
        ),
      ),
    );
  }
}
