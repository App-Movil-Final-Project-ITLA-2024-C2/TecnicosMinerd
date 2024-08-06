import 'package:flutter/material.dart';
import '../pages/logged/weather_page.dart';
import '../utils/get_token_util.dart';
import '../pages/logged/addvisitpage.dart';
import '../pages/logged/director_search.dart';
import '../pages/logged/horoscopepage.dart';
import '../pages/logged/newspage.dart';
import '../pages/logged/school_search.dart';
import '../pages/logged/visittypes_search.dart';
import '../utils/navigation_util.dart';
import '../widgets/homeloggedpage/bottommenu.dart';
import '../widgets/homeloggedpage/visitlist.dart';

class HomeLoggedScreen extends StatefulWidget {
  const HomeLoggedScreen({super.key});

  @override
  State<HomeLoggedScreen> createState() => _HomeLoggedScreenState();
}

class _HomeLoggedScreenState extends State<HomeLoggedScreen> {
  String? _token;
  final GlobalKey<VisitListState> _visitListKey = GlobalKey<VisitListState>();

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    _token = await TokenUtil.getToken();
    setState(() {});
  }

  Future<void> _addVisitPage() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddVisitPage(onVisitAdded: _updateVisitList),
      ),
    );
  }

  Future<void> _updateVisitList() async {
    _visitListKey.currentState?.refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 10,
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
                  child: Image.network('https://static.wikia.nocookie.net/logopedia/images/c/c3/LogoEducacion2020.1.png'),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.business),
              title: const Text('Tipos de Visitas'),
              onTap: () {
                NavigationUtils.navigateToPage(context, VisitTypesPage());
              },
            ),
            ListTile(
              leading: const Icon(Icons.search),
              title: const Text('Escuela por Código'),
              onTap: () {
                NavigationUtils.navigateToPage(context, SearchSchoolPage());
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Director por Código'),
              onTap: () {
                NavigationUtils.navigateToPage(context, SearchDirectorPage());
              },
            ),
            ListTile(
              leading: const Icon(Icons.newspaper),
              title: const Text('Noticias'),
              onTap: () {
                NavigationUtils.navigateToPage(context, NewsPage());
              },
            ),
            ListTile(
              leading: const Icon(Icons.star),
              title: const Text('Horóscopo'),
              onTap: () {
                NavigationUtils.navigateToPage(context, HoroscopePage());
              },
            ),
            ListTile(
              leading: const Icon(Icons.cloud),
              title: const Text('Clima'),
              onTap: () {
                NavigationUtils.navigateToPage(context, const WeatherPage());
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
              Expanded(
                child: _token == null
                    ? const Center(child: CircularProgressIndicator())
                    : VisitList(key: _visitListKey, token: _token!),
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
