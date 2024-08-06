import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:record/record.dart';
import 'dart:io';

import '../../models/visit_model.dart';
import '../../models/visittype_model.dart'; // Importa el modelo de VisitType
import '../../services/visit_service.dart';
import '../../services/visittype_service.dart'; // Importa el servicio de VisitType

class AddVisitPage extends StatefulWidget {
  final VoidCallback? onVisitAdded;

  const AddVisitPage({super.key, this.onVisitAdded});

  @override
  State<AddVisitPage> createState() => _AddVisitPageState();
}

class _AddVisitPageState extends State<AddVisitPage> {
  final _formKey = GlobalKey<FormState>();
  final VisitService _visitService = VisitService();
  final ImagePicker _picker = ImagePicker();
  final Record _audioRecorder = Record();

  final TextEditingController _cedulaDirectorController = TextEditingController();
  final TextEditingController _codigoCentroController = TextEditingController();
  final TextEditingController _comentarioController = TextEditingController();
  final TextEditingController _latitudController = TextEditingController();
  final TextEditingController _longitudController = TextEditingController();

  String? _fotoEvidenciaPath;
  String? _notaVozPath;
  String? _token;
  String? _selectedMotivo;
  List<VisitType> _visitTypes = []; // Lista de tipos de visita

  bool _isRecording = false;

  @override
  void initState() {
    super.initState();
    _loadToken();
    _requestPermissions();
    _fetchVisitTypes(); // Cargar los tipos de visitas
  }

  Future<void> _fetchVisitTypes() async {
    try {
      _visitTypes = await VisitTypeService().getVisitTypes(); // Obtener los tipos de visita desde el servicio
      if (_visitTypes.isNotEmpty) {
        setState(() {
          _selectedMotivo = _visitTypes.first.name; // Establecer un motivo predeterminado si la lista no está vacía
        });
      }
    } catch (e) {
      log("Error al cargar los tipos de visita: $e");
    }
  }

  Future<void> _loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');
    if (userJson != null) {
      Map<String, dynamic> userMap = jsonDecode(userJson);
      _token = userMap['token'];
    }
  }

  Future<void> _requestPermissions() async {
    final status = await Permission.microphone.request();
    if (!status.isGranted) {
      log('Permiso de grabación de audio denegado.');
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _fotoEvidenciaPath = pickedFile.path;
      });
    }
  }

  Future<void> _startRecording() async {
    try {
      final directory = await Directory.systemTemp.createTemp();
      final path = '${directory.path}/audio.m4a';

      // Inicio de la grabación
      await _audioRecorder.start(
        path: path,
        encoder: AudioEncoder.aacLc,
      );

      setState(() {
        _isRecording = true;
        _notaVozPath = path;
      });
    } catch (e) {
      log("Error al iniciar la grabación: $e");
    }
  }

  Future<void> _stopRecording() async {
    try {
      final path = await _audioRecorder.stop();
      setState(() {
        _isRecording = false;
        _notaVozPath = path;
      });
    } catch (e) {
      log("Error al detener la grabación: $e");
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate() && _token != null) {
      Visit visit = Visit(
        cedulaDirector: _cedulaDirectorController.text,
        codigoCentro: _codigoCentroController.text,
        motivo: _selectedMotivo!,
        fotoEvidencia: _fotoEvidenciaPath!,
        comentario: _comentarioController.text,
        notaVoz: _notaVozPath!,
        latitud: _latitudController.text,
        longitud: _longitudController.text,
        fecha: DateTime.now().toIso8601String().split('T').first,
        hora: TimeOfDay.now().format(context),
        token: _token!,
      );

      try {
        bool success = await _visitService.registerVisit(visit);
        if (success) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Visita registrada con éxito')),
            );
            Navigator.of(context).pop();
            widget.onVisitAdded?.call(); // Llama al callback
          }
        }
      } catch (error) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $error')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Añadir Visitas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 150,
                  child: Image.network('https://static.wikia.nocookie.net/logopedia/images/c/c3/LogoEducacion2020.1.png'),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _cedulaDirectorController,
                  decoration: const InputDecoration(labelText: 'Cedula Director'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese la cedula del director';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _codigoCentroController,
                  decoration: const InputDecoration(labelText: 'Código Centro'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el código del centro';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: _selectedMotivo,
                  decoration: const InputDecoration(labelText: 'Motivo'),
                  items: _visitTypes.map((VisitType visitType) {
                    return DropdownMenuItem<String>(
                      value: visitType.name,
                      child: Text(visitType.name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedMotivo = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor seleccione un motivo';
                    }
                    return null;
                  },
                  isExpanded: true,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _comentarioController,
                  decoration: const InputDecoration(labelText: 'Comentario'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese un comentario';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _latitudController,
                  decoration: const InputDecoration(labelText: 'Latitud'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese la latitud';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _longitudController,
                  decoration: const InputDecoration(labelText: 'Longitud'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese la longitud';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _fotoEvidenciaPath == null
                        ? const Text('Tome una Imagen.')
                        : Image.file(File(_fotoEvidenciaPath!), width: 100),
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
                        : _notaVozPath == null
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
                    onPressed: _submitForm,
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Registrar Visita'),
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
