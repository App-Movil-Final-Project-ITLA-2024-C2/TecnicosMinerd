import 'package:flutter/material.dart';
import '../../models/visittype_model.dart';
import '../../services/visittype_service.dart';

class VisitTypesPage extends StatelessWidget {
  const VisitTypesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tipos de Visitas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: SizedBox(
                width: double.infinity,
                child: Image.network('https://static.wikia.nocookie.net/logopedia/images/c/c3/LogoEducacion2020.1.png'),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<VisitType>>(
                future: VisitTypeService().getVisitTypes(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    final visitTypes = snapshot.data!;
                    if (visitTypes.isEmpty) {
                      return const Center(child: Text('No hay tipos de visitas disponibles.'));
                    }
                    return ListView.builder(
                      itemCount: visitTypes.length,
                      itemBuilder: (context, index) {
                        final visitType = visitTypes[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(8.0),
                            title: Text(
                              visitType.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            tileColor: Colors.grey[100],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            onTap: () {
                              _showVisitTypeDetails(context, visitType);
                            },
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text('No se encontraron tipos de visitas.'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showVisitTypeDetails(BuildContext context, VisitType visitType) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(visitType.name),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(visitType.description),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
