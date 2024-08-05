class News {
  final String title;
  final String? image;
  final String description;
  final String content;
  final String link;

  News({
    required this.title,
    this.image,
    required this.description,
    required this.content,
    required this.link,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'] ?? 'No Title',
      image: json['image'],
      description: json['description'] ?? 'No Description',
      content: json['content'] ?? 'No Content',
      link: json['link'] ?? '',
    );
  }
}