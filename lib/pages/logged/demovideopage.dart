import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DemoVideoPage extends StatefulWidget {
  const DemoVideoPage({super.key});

  @override
  DemoVideoPageState createState() => DemoVideoPageState();
}

class DemoVideoPageState extends State<DemoVideoPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId('https://youtu.be/c-X8yAM8rnU')!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Demostrativo'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20), // Espacio entre el video y la lista         
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  'Participantes',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20), 
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• Hilari Medina Feliz, 2022-1025'),
                    SizedBox(height: 20),
                    Text('• Yira Steysi Marchitelli Crispin, 2022-0263'),
                    SizedBox(height: 20),
                    Text('• Albieri Rafael Garcia Ortiz, 2022-0004'),
                    SizedBox(height: 20),          
                    Text('• Deivi Cristopher Aquino Perez, 2022-2021'),
                     SizedBox(height: 20),
                    Text('• Elias Jose Mariñez Perez, 2022-1073'),
                  ],
                ),
              ],
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
