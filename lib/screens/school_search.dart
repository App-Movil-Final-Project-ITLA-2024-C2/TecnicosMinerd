import 'package:flutter/material.dart';
import '../models/school_model.dart';
import '../services/api_service.dart';
import '../screens/director_search.dart';

class SchoolSearchScreen extends StatefulWidget {
  @override
  _SchoolSearchScreenState createState() => _SchoolSearchScreenState();
}

class _SchoolSearchScreenState extends State<SchoolSearchScreen> {
  List<School> _schools = [];
  bool _isLoading = false;
  TextEditingController _controller = TextEditingController();
  String _searchMessage = '';

  @override
  void initState() {
    super.initState();
  }

 Future<void> _searchSchools() async {
  String codigo = _controller.text.trim();
  if (codigo.isEmpty) {
    setState(() {
      _searchMessage = 'Por favor, ingrese un código de escuela.';
      _schools = [];
    });
    return;
  }

  setState(() {
    _isLoading = true;
    _searchMessage = 'Buscando escuelas con código: $codigo';
  });

  try {
    _schools = await fetchSchools(codigo: codigo);
    setState(() {
      if (_schools.isEmpty) {
        _searchMessage = 'No se encontraron escuelas con el código: $codigo';
      } else {
        _searchMessage = 'Se encontraron ${_schools.length} escuela(s) con el código: $codigo';
      }
    });
  } catch (e) {
    setState(() {
      _searchMessage = 'Error al buscar escuelas: $e';
      _schools = [];
    });
  } finally {
    setState(() => _isLoading = false);
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscar Escuelas'),
        
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Ingrese el código de la escuela',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _searchSchools,
                ),
              ),
              onSubmitted: (_) => _searchSchools(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _searchMessage,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
  itemCount: _schools.length,
  itemBuilder: (context, index) {
    School school = _schools[index];
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        title: Text(school.nombre ?? 'Nombre no disponible'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Código: ${school.codigo ?? 'No disponible'}'),
            Text('Distrito: ${school.distrito ?? 'No disponible'}'),
            Text('Regional: ${school.regional ?? 'No disponible'}'),
            Text('Coordenadas: ${school.coordenadas ?? 'No disponible'}'),
            Text('Distrito Municipal: ${school.dMunicipal ?? 'No disponible'}'),
          ],
        ),
        isThreeLine: true,
      ),
    );
  },
),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
