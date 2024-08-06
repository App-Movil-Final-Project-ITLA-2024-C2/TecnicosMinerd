import 'package:flutter/material.dart';
import 'package:tecnicos_minerd/screens/homescreen.dart';
import '../../services/incident_service.dart';
import '../../utils/navigation_util.dart';

class DeletePage extends StatelessWidget {
  const DeletePage({super.key});

  void _deleteAllIncidents(BuildContext context) async {
    final incidentService = IncidentService();
    await incidentService.deleteAllIncidents();
    if (context.mounted) {
      NavigationUtils.navigateAndReplace(context, const MyHomeScreen());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Todos los incidentes han sido borrados.'),
        ),
      );
    }
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Advertencia'),
          content: const Text(
            'Esta función no es reversible, todos los registros e informaciones de la base de datos serán borradas en su totalidad.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => _deleteAllIncidents(context),
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eliminar'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.warning,
                size: 80.0, // Aumentado el tamaño del ícono
                color: Colors.red, // Cambiado el color del ícono a rojo
              ),
              const SizedBox(height: 10),
              const Text(
                'Advertencia',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Esta función no es reversible, todos los registros e informaciones de la base de datos serán borradas en su totalidad',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity, // Ancho completo
                child: ElevatedButton(
                  onPressed: () => _showDeleteConfirmationDialog(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Fondo rojo
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Eliminar Todos los Incidentes'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
