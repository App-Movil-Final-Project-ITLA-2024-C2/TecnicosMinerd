import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../models/news_model.dart';
import '../../utils/html_util.dart';
import '../../widgets/shimmer_item.dart';
import 'newsdetailpage.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  NewsPageState createState() => NewsPageState();
}

class NewsPageState extends State<NewsPage> {
  late Future<List<News>> futureNews;
  final Random random = Random();

  @override
  void initState() {
    super.initState();
    futureNews = fetchNews();
  }

  Future<List<News>> fetchNews() async {
    try {
      final response = await http
          .get(Uri.parse('https://adamix.net/Minerd/def/noticias.php'));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => News.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load news: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load news: $e');
    }
  }

  String getRandomNumber() {
    double number = random.nextDouble() * (50.9 - 1) + 1;
    return '${number.toStringAsFixed(1)}k';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Noticias'),
      ),
      body: FutureBuilder<List<News>>(
        future: futureNews,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView.separated(
              itemCount: 5, 
              itemBuilder: (context, index) => const ShimmerItem(),
              separatorBuilder: (context, index) => const Divider(
                color: Colors.grey,
                thickness: 0.5,
              ),
            );
          } else if (snapshot.hasData) {
            return ListView.separated(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                News news = snapshot.data![index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsDetailPage(news: news),
                      ),
                    );
                  },
                  child: Container(
                    color: Colors.white, // Fondo blanco
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ClipOval(
                              child: Image.asset(
                                'assets/icon/icon.png',
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Expanded(
                              child: Text(
                                news.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 48.0), 
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                HtmlUtil.processText(news.description),
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(height: 8.0),
                              if (news.image != null)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    news.image!,
                                    height: 150,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              const SizedBox(height: 8.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  _buildIconText(
                                      Icons.message, getRandomNumber()),
                                  const SizedBox(width: 16.0),
                                  _buildIconText(
                                      Icons.thumb_up, getRandomNumber()),
                                  const SizedBox(width: 16.0),
                                  _buildIconText(
                                      Icons.visibility, getRandomNumber()),
                                  const SizedBox(width: 16.0),
                                  _buildIconText(
                                      Icons.share, getRandomNumber()),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(
                color: Colors.grey,
                thickness: 0.5,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildIconText(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.grey,
        ),
        const SizedBox(width: 4.0),
        Text(
          text,
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}