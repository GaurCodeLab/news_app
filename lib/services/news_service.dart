import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:news_app/models/news_article.dart';
import 'package:news_app/secrets.dart';

/// A service class responsible for fetching and managing news data.
/// 
/// This class provides methods to retrieve news articles from various sources,
/// handle data processing, and manage any related business logic.
class NewsService {
  
  final String apiKey = Secrets.apiKey;
  final String _baseUrl = 'https://newsapi.org/v2';

  /// Fetches a list of news articles.
  ///
  /// The [page] parameter specifies the page number of the news articles to fetch.
  /// Defaults to 1 if not provided.
  ///
  /// Returns a [Future] that completes with a list of [NewsArticle] objects.
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
