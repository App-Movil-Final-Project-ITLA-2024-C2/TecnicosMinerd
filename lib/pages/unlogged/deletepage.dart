import 'package:flutter/material.dart';
import 'dart:async';


class DeletePage extends StatelessWidget {

  const DeletePage({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Página de Seguridad',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SecurityPage(),
    );
  }
}

class SecurityPage extends StatelessWidget {
  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:  (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          contentPadding:  const EdgeInsets.all(20.0),
          titlePadding: const EdgeInsets.only(top: 20.0),
          title: Container(
            alignment: Alignment.center,
            child: const Text(
              'Ingrese la contraseña',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: SizedBox(
            width: 400.0,
            height: 180.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Contraseña',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                  ),
                ),
                SizedBox(height: 20.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Cierra el diálogo
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => LoadingPage(),
                        ),
                      );
                    },
                    child: Text('Aceptar'),
                  ),
                ),
                SizedBox(height: 10.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancelar'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Fondo
          Positioned.fill(
            child: Container(
              color: Color.fromARGB(255, 255, 255, 255),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 10,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                ),
                itemBuilder: (context, index) {
                  return Icon(
                    Icons.warning,
                    color: Color.fromARGB(255, 7, 93, 221).withOpacity(0.1),
                  );
                },
                itemCount: 140,
                shrinkWrap: true,
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 70.0, 20.0, 8.0),
                      child: Container(
                        height: 120, // Altura del primer recuadro
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color.fromARGB(255, 179, 175, 175), 
                              Color.fromARGB(255, 119, 116, 116), 
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.photo,
                                  size: 40.0,
                                  color: Colors.cyan,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Fotos',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  '200', 
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.audiotrack,
                                  size: 40.0,
                                  color: Colors.purple,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Audios',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  '150', 
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.videocam,
                                  size: 40.0,
                                  color: Color.fromARGB(255, 250, 136, 5),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Videos',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  '75', 
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 10.0),
                      child:  Container(
                        height: 220,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color.fromARGB(255, 245, 243, 243), // Gris claro
                              Color.fromARGB(255, 179, 175, 175), // Gris oscuro
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.person,
                                  size: 60.0,
                                  color: Color.fromARGB(255, 16, 52, 212),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Visitas',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  '12345', // Número de visitas
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.security_update_warning,
                                  size: 60.0,
                                  color: Color.fromARGB(255, 16, 52, 212),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Incidencias',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  '678', 
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.4, // 40% de la altura de la pantalla
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 165, 18, 18), // Rojo claro
                      Color.fromARGB(255, 56, 2, 2), // Rojo oscuro
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: const Center(
                  child: Column(
                    children: [
                      SizedBox(height: 40),
                      Icon(
                        Icons.warning,
                        size: 50.0,
                        color: Colors.yellow,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Advertencia',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          'Esta función no es reversible, '
                          'todos los registros e informaciones de la '
                          'base de datos serán borradas en su totalidad',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color.fromARGB(255, 150, 146, 146), // Color del texto
                ),
                onPressed: () => _showDeleteDialog(context),
                child: const Text('Borrar Registros'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  double _progress = 0;
  String _loadingText = 'Borrando registros';

  @override
  void initState() {
    super.initState();
    _startLoading();
    _startLoadingTextAnimation();
  }

  void _startLoading() async {
    for (double i = 0; i <= 100; i++) {
      await Future.delayed(Duration(milliseconds: 50));
      setState(() {
        _progress = i;
      });
    }
    // Regresar a la página inicial
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  void _startLoadingTextAnimation() {
    Timer.periodic(Duration(milliseconds: 500), (timer) {
      if (mounted) {
        setState(() {
          if (_loadingText.endsWith('...')) {
            _loadingText = 'Borrando registros';
          } else {
            _loadingText += '.';
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _loadingText,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(
              value: _progress / 100,
              strokeWidth: 8,
            ),
            SizedBox(height: 20),
            Text(
              '${_progress.toStringAsFixed(0)}%',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}