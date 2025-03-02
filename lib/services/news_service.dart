import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:news_app/models/news_article.dart';
import 'package:news_app/secrets.dart';

class NewsService {
  
  final String apiKey = Secrets.apiKey;
  final String _baseUrl = 'https://newsapi.org/v2';

  Future<List<NewsArticle>> fetchNews({int page = 1}) async {
    final response = await http.get(
      Uri.parse(
        '$_baseUrl/top-headlines?country=us&pageSize=20&page=$page&apiKey=$apiKey',
      ),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List articles = data['articles'];
      return articles.map((json) => NewsArticle.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
