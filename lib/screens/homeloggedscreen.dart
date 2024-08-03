import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/logged/demovideopage.dart';
import '../pages/logged/director_search.dart';
import '../pages/logged/horoscopepage.dart';
import '../pages/logged/newspage.dart';
import '../pages/logged/school_search.dart';
import '../pages/logged/visitsmaps.dart';
import '../pages/logged/visittypes_search.dart';
import 'homescreen.dart';
import '../utils/navigation_util.dart';
import '../pages/incidents/addincidentpage.dart';
import '../widgets/homeloggedpage/bottommenu.dart';

class HomeLoggedScreen extends StatefulWidget {
  const HomeLoggedScreen({super.key});

  @override
  State<HomeLoggedScreen> createState() => _HomeLoggedScreenState();
}

class _HomeLoggedScreenState extends State<HomeLoggedScreen> {

  Future<void> _addVisitPage() async {
    NavigationUtils.navigateToPage(context, const AddIncidentPage());
  }

  Future<void> _logout() async {
    await _clearUserData();

    // Mostrar el mensaje de sesión cerrada
    if(mounted){    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Sesión cerrada con éxito'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );}

    // Redirigir a la página de inicio de sesión después de un pequeño retraso
    await Future.delayed(const Duration(seconds: 2));
    if(mounted){
      NavigationUtils.navigateAndReplace(context, const MyHomeScreen());
    }
  }

  Future<void> _clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 5,
        title: const SizedBox.shrink(),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Center(
                child: SizedBox(
                  width: double.infinity,
                  child: Image.network('https://static.wikia.nocookie.net/logopedia/images/c/c3/LogoEducacion2020.1.png')
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.business),
              title: const Text('Tipos de Visitas'),
              onTap: () {
                NavigationUtils.navigateToPage(context, const VisitTypesPage());
              },
            ),
            ListTile(
              leading: const Icon(Icons.search),
              title: const Text('Escuela por Código'),
              onTap: () {
                NavigationUtils.navigateToPage(context, const SearchSchoolPage());
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Director por Código'),
              onTap: () {
                NavigationUtils.navigateToPage(context, const SearchDirectorPage());
              },
            ),
            ListTile(
              leading: const Icon(Icons.map),
              title: const Text('Mapa de Visitas'),
              onTap: () {
                NavigationUtils.navigateToPage(context, const VisitsMapsPage());
              },
            ),
            ListTile(
              leading: const Icon(Icons.newspaper),
              title: const Text('Noticias'),
              onTap: () {
                NavigationUtils.navigateToPage(context, const NewsPage());
              },
            ),
            ListTile(
              leading: const Icon(Icons.star),
              title: const Text('Horóscopo'),
              onTap: () {
                NavigationUtils.navigateToPage(context, const HoroscopePage());
              },
            ),
            ListTile(
              leading: const Icon(Icons.video_library),
              title: const Text('Video Demostrativo'),
              onTap: () {
                NavigationUtils.navigateToPage(context, const DemoVideoPage());
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Cerrar Sesión'),
              onTap: () {
                _logout(); // Llama al método para cerrar sesión
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: Image.network(
                    'https://static.wikia.nocookie.net/logopedia/images/c/c3/LogoEducacion2020.1.png',
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Aquí van las listas de visitas',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addVisitPage,
        shape: const CircleBorder(),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
        child: const Icon(Icons.add_location),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomMenu(),
    );
  }
}
