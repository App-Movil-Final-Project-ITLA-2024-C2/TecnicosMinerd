import 'package:flutter/material.dart';
import '../../models/school_model.dart';
import '../../services/school_service.dart';
import '../../widgets/mapwidget.dart';

class SearchSchoolPage extends StatefulWidget {
  const SearchSchoolPage({super.key});

  @override
  SearchSchoolPageState createState() => SearchSchoolPageState();
}

class SearchSchoolPageState extends State<SearchSchoolPage> {
  final _formKey = GlobalKey<FormState>();
  String _schoolCode = '';
  Future<School?>? _searchFuture;
  String? _errorMessage;
  bool _hasSearched = false;
  final SchoolService _schoolService = SchoolService();

  void _searchSchool() {
    setState(() {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        _searchFuture = _schoolService.schoolByCode(codigo: _schoolCode)
            .then((school) {
              _hasSearched = true;
              return school;
            })
            .catchError((e) {
              _errorMessage = 'Error al buscar la escuela: ${e.toString()}';
              _hasSearched = true; 
              return null;
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buscar Escuela')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Código de la Escuela',
                      labelStyle: TextStyle(fontSize: 16),
                    ),
                    style: const TextStyle(fontSize: 16),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese el código de la escuela';
                      }
                      return null;
                    },
                    onSaved: (value) => _schoolCode = value!,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _searchSchool,
                      child: const Text('Buscar'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            Expanded(
              child: FutureBuilder<School?>(
                future: _searchFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    final school = snapshot.data;
                    if (school == null) {
                      return _hasSearched
                          ? const Center(
                              child: Text(
                                'No se encontró la escuela.',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : const SizedBox.shrink();
                    }
                    final coordenadas = school.coordenadas?.split(',') ?? [];
                    double latitude = coordenadas.isNotEmpty ? double.tryParse(coordenadas[0]) ?? 0 : 0;
                    double longitude = coordenadas.length > 1 ? double.tryParse(coordenadas[1]) ?? 0 : 0;
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          children: [
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            school.nombre ?? 'No disponible',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 21,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            overflow: TextOverflow.ellipsis, 
                                            maxLines: 3,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      children: [
                                        const Text(
                                          'Código: ',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          school.codigo ?? 'No disponible',
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Text(
                                              'Distrito: ',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              school.distrito ?? 'No disponible',
                                              style: const TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              ',   Regional: ',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              school.regional ?? 'No disponible',
                                              style: const TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'Municipal:',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Center(
                                      child: Text(
                                        school.dMunicipal ?? 'No disponible',
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    MapWidget(
                                      latitude: latitude,
                                      longitude: longitude,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return _hasSearched
                        ? const Center(
                            child: Text(
                              'No se encontró la escuela.',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : const SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
