import 'package:get/get.dart';
import '../models/news_article.dart';
import '../services/news_service.dart';

class NewsViewModel extends GetxController {
  final NewsService _newsService = NewsService();
  var articles = <NewsArticle>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchNews();
    super.onInit();
  }

  Future<void> fetchNews({int page = 1, bool refresh = false}) async {
    if (refresh) {
      articles.clear();
    }
    isLoading(true);
    try {
      var fetchedArticles = await _newsService.fetchNews(page: page);
      articles.assignAll(fetchedArticles);
    } catch (error) {
      errorMessage('Error fetching news');
    } finally {
      isLoading(false);
    }
  }

  void removeArticle(int index) {
    articles.removeAt(index);
  }

  // For search functionality later: filter articles based on title or description
  void searchNews(String query) {
    if (query.isEmpty) {
      // Optionally, refetch news if the query is empty or maintain original list
      fetchNews();
    } else {
      var filtered =
          articles
              .where(
                (article) {
                  final title = article.title.toLowerCase();
                  final description = article.description.toLowerCase();
                  return title.contains(query.toLowerCase()) ||
                      description.contains(query.toLowerCase());
    })
              .toList();
      articles.assignAll(filtered);
    }
  }
}
