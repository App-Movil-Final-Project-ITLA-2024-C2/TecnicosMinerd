import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';  
import 'package:tecnicos_minerd/models/incident_model.dart';
import 'package:tecnicos_minerd/services/incident_service.dart';

class AddIncidentScreen extends StatefulWidget {
  const AddIncidentScreen({super.key});

  @override
  _AddIncidentScreenState createState() => _AddIncidentScreenState();
}

class _AddIncidentScreenState extends State<AddIncidentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _incidentService = IncidentService();

  final _titleController = TextEditingController();
  final _schoolNameController = TextEditingController(); 
  final _regionalController = TextEditingController();
  final _districtController = TextEditingController();
  final _dateController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _photoPath;
  String? _audioPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Incidencia'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Título'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un título';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _schoolNameController,  
                decoration: const InputDecoration(labelText: 'Centro Educativo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre del centro educativo';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _regionalController,
                decoration: const InputDecoration(labelText: 'Regional'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la regional';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _districtController,
                decoration: const InputDecoration(labelText: 'Distrito'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el distrito';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(labelText: 'Fecha'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la fecha';
                  }
                  return null;
                },
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    _dateController.text =
                        "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                  }
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una descripción';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  final pickedFile = await ImagePicker().pickImage(
                    source: ImageSource.gallery,
                  );
                  if (pickedFile != null) {
                    setState(() {
                      _photoPath = pickedFile.path;
                    });
                  }
                },
                child: const Text('Seleccionar Foto'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final result = await FilePicker.platform.pickFiles(
                    type: FileType.audio,
                  );
                  if (result != null && result.files.single.path != null) {
                    setState(() {
                      _audioPath = result.files.single.path!;
                    });
                  }
                },
                child: const Text('Seleccionar Audio'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newIncident = Incident(
                      title: _titleController.text,
                      schoolName: _schoolNameController.text,  
                      regional: _regionalController.text,
                      district: _districtController.text,
                      date: _dateController.text,
                      description: _descriptionController.text,
                      photo: _photoPath,
                      audio: _audioPath,
                    );
                    _incidentService.insertIncident(newIncident).then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Incidencia guardada correctamente')));
                      Navigator.pop(context);
                    });
                  }
                },
                child: const Text('Guardar Incidencia'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
