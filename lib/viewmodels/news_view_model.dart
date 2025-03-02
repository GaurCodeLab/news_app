import 'package:get/get.dart';
import '../models/news_article.dart';
import '../services/news_service.dart';

/// A ViewModel class that extends `GetxController` to manage the state and logic
/// for the news-related views in the application.
///
/// This class is responsible for handling the business logic and state management
/// for the news features, such as fetching news articles, updating the UI, and
/// reacting to user interactions.
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

  /// Fetches news articles from the server.
  ///
  /// This method retrieves news articles from the server and updates the
  /// corresponding view model. It supports pagination and can optionally
  /// refresh the current list of articles.
  ///
  /// [page] specifies the page number to fetch. Defaults to 1.
  /// [refresh] indicates whether to refresh the current list of articles.
  /// If true, the current list will be cleared before fetching new articles.
  ///
  /// Returns a [Future] that completes when the fetch operation is done.
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

  /// Removes an article from the list at the specified index.
  /// Throws an `IndexError` if the index is out of range.
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
