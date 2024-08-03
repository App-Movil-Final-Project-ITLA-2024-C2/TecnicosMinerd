import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:tecnicos_minerd/services/incident_service.dart';
import '../../models/incident_model.dart';

class AddIncidentPage extends StatefulWidget {
  const AddIncidentPage({super.key});

  @override
  AddIncidentPageState createState() => AddIncidentPageState();
}

class AddIncidentPageState extends State<AddIncidentPage> {
  final _incidentService = IncidentService();

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _schoolNameController = TextEditingController(); 
  final _regionalController = TextEditingController();
  final _districtController = TextEditingController();
  final _dateController = TextEditingController();
  final _descriptionController = TextEditingController();
  File? _imageFile;
  String? _audioFilePath;

  final _record = Record();
  bool _isRecording = false;

  Future<void> _requestPermissions() async {
    final status = await Permission.microphone.request();
    if (!status.isGranted) {
      log('Permiso de grabación de audio denegado.');
    }
  }

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }

  Future<void> _startRecording() async {
    try {
      final directory = await Directory.systemTemp.createTemp();
      final path = '${directory.path}/audio.m4a';

      // Inicio de la grabación
      await _record.start(
        path: path,
        encoder: AudioEncoder.aacLc,
      );

      setState(() {
        _isRecording = true;
        _audioFilePath = path;
      });
    } catch (e) {
      log("Error al iniciar la grabación: $e");
    }
  }

  Future<void> _stopRecording() async {
    try {
      final path = await _record.stop();
      setState(() {
        _isRecording = false;
        _audioFilePath = path;
      });
    } catch (e) {
      log("Error al detener la grabación: $e");
    }
  }

  Future<void> _saveIncident() async {
    if (_isRecording) await _stopRecording();

    final incident = Incident(
      title: _titleController.text,
      schoolName: _schoolNameController.text,
      regional: _regionalController.text,
      district: _districtController.text,
      date: _dateController.text,
      description: _descriptionController.text,
      photo: _imageFile?.path,
      audio: _audioFilePath,
    );

    _incidentService.insertIncident(incident).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Incidente guardada correctamente')));
      Navigator.pop(context);
    });
  }

  @override
  void dispose() {
    _record.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Incidente'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: <Widget>[
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
                const SizedBox(height: 20),
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
                const SizedBox(height: 20),
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
                const SizedBox(height: 20),
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
                const SizedBox(height: 20),
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
                const SizedBox(height: 20),
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
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _imageFile == null
                        ? const Text('Tome una Imagen.')
                        : Image.file(_imageFile!, width: 100),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[500],
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt, color: Colors.white),
                        onPressed: _pickImage,
                        tooltip: 'Tomar una foto',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _isRecording
                        ? const Text('Grabando audio....')
                        : _audioFilePath == null
                            ? const Text('No ha grabado audio.')
                            : const Text('El audio ha sido grabado.'),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[500],
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(
                          _isRecording ? Icons.stop : Icons.mic,
                          color: Colors.white,
                        ),
                        onPressed: _isRecording ? _stopRecording : _startRecording,
                        tooltip: _isRecording ? 'Detener grabación' : 'Grabar audio',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saveIncident,
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Guardar Incidente'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
