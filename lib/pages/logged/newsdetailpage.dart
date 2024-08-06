// Página de detalles de la noticia
import 'package:flutter/material.dart';

import '../../models/news_model.dart';
import '../../utils/html_util.dart';
import '../../utils/urls_util.dart';

class NewsDetailPage extends StatelessWidget {
  final News news;

  const NewsDetailPage({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(news.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (news.image != null) Image.network(news.image!),
              const SizedBox(height: 8.0),
              Text(
                news.title,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Text(HtmlUtil.processText(news.description)),
              const SizedBox(height: 16.0),
              Text(HtmlUtil.processText(news.content)),
              const SizedBox(height: 16.0),
             Center(
                child: GestureDetector(
                  onTap: () => UrlsUtil.launchURL(news.link),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Leer más',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}