import 'package:flutter/material.dart';
import 'package:tecnicos_minerd/pages/incidents/addincidentpage.dart';
import 'package:tecnicos_minerd/widgets/homepage/incidentlist.dart';

import '../utils/navigation_util.dart';
import '../widgets/homepage/bottommenu.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {

  final GlobalKey<IncidentListState> _incidentListKey = GlobalKey<IncidentListState>();

  Future<void> _addIncidentPage() async{
    await NavigationUtils.navigateToPage(context, const AddIncidentPage());
    _incidentListKey.currentState?.refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 10,
        title: const SizedBox.shrink(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 5,
            ),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: Image.network('https://static.wikia.nocookie.net/logopedia/images/c/c3/LogoEducacion2020.1.png')
              ),
            ),
            const SizedBox(height: 20.0), // Espacio entre la línea y la lista
            Expanded(
              child: IncidentList(key: _incidentListKey,),
            )
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _addIncidentPage,
        shape: const CircleBorder(),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
        child: const Icon(Icons.add), // Asegura que el botón sea redondo
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomMenu(),
    );
  }
}
