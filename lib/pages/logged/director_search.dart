import 'package:flutter/material.dart';
import 'package:tecnicos_minerd/models/director_model.dart';
import 'package:tecnicos_minerd/services/director_service.dart';


class SearchDirectorPage extends StatefulWidget {
  const SearchDirectorPage({super.key});

  @override
  SearchDirectorPageState createState() => SearchDirectorPageState();
}

class SearchDirectorPageState extends State<SearchDirectorPage> {
  final _formKey = GlobalKey<FormState>();
  String _identification = '';
  Director? _director;
  String? _errorMessage;
  final DirectorService _directorService = DirectorService();

  void _searchDirector() async {
    setState(() {
      _director = null;
      _errorMessage = null;
    });

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        final director = await _directorService.getDirectorById(_identification);
        setState(() {
          if (director != null) {
            _director = director;
          } else {
            _errorMessage = 'Director no encontrado';
          }
        });
      } catch (e) {
        setState(() {
          _errorMessage = 'Error al buscar el director: ${e.toString()}';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buscar Director')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Cédula del Director'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la cédula del director';
                  }
                  return null;
                },
                onSaved: (value) => _identification = value!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _searchDirector,
                child: const Text('Buscar'),
              ),
              const SizedBox(height: 20),
              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              if (_director != null) ...[
                Text('Nombre: ${_director!.firstName} ${_director!.lastName}'),
                Text('Fecha de nacimiento: ${_director!.birthDate}'),
                Text('Dirección: ${_director!.address}'),
                Text('Teléfono: ${_director!.phoneNumber}'),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
