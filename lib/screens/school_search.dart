import 'package:flutter/material.dart';
import 'package:tecnicos_minerd/models/school_model.dart';
import 'package:tecnicos_minerd/services/school_service.dart';


class SearchSchoolScreen extends StatefulWidget {
  @override
  _SearchSchoolScreenState createState() => _SearchSchoolScreenState();
}

class _SearchSchoolScreenState extends State<SearchSchoolScreen> {
  final _formKey = GlobalKey<FormState>();
  String _schoolCode = '';
  School? _school;
  String? _errorMessage;
  final SchoolService _schoolService = SchoolService();

  void _searchSchool() async {
    setState(() {
      _school = null;
      _errorMessage = null;
    });

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        final school = await _schoolService.getSchoolByCode(_schoolCode);
        setState(() {
          if (school != null) {
            _school = school;
          } else {
            _errorMessage = 'Escuela no encontrada';
          }
        });
      } catch (e) {
        setState(() {
          _errorMessage = 'Error al buscar la escuela: ${e.toString()}';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Buscar Escuela')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Código de la Escuela'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el código de la escuela';
                  }
                  return null;
                },
                onSaved: (value) => _schoolCode = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _searchSchool,
                child: Text('Buscar'),
              ),
              SizedBox(height: 20),
              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              if (_school != null) ...[
                Text('Nombre: ${_school!.name}'),
                Text('Dirección: ${_school!.address}'),
                Text('Teléfono: ${_school!.phoneNumber}'),
              ]
            ],
          ),
        ),
      ),
    );
  }
}