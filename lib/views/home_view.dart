import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/widgets/news_card.dart';
import 'package:shimmer/shimmer.dart';
import '../viewmodels/news_view_model.dart';
import '../models/news_article.dart';

class HomeView extends StatelessWidget {
  final NewsViewModel newsVM = Get.put(NewsViewModel());

   HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              onChanged: (query) => newsVM.searchNews(query),
              decoration: InputDecoration(
                hintText: 'Search articles...',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (newsVM.isLoading.value) {
          return ListView.builder(itemBuilder: (context, index) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: ListTile(
                leading: Container(
                  width: 100,
                  height: 100,
                  color: Colors.white,
                ),
                title: Container(
                  height: 20,
                  color: Colors.white,
                ),
                subtitle: Container(
                  height: 20,
                  color: Colors.white,
                ),
              ),
            );
          });
        } else if (newsVM.errorMessage.isNotEmpty) {
          return Center(child: Text(newsVM.errorMessage.value));
        } else {
          return RefreshIndicator(
            onRefresh: () async {
              await newsVM.fetchNews(refresh: true);
            },
            child: ListView.builder(
             itemCount: newsVM.articles.length,
              itemBuilder: (context, index) {
                NewsArticle? article = newsVM.articles[index];
            
                return Dismissible(
                  key: Key(article.title), // Unique key for each item
                  direction:
                      DismissDirection
                          .horizontal, // Allow swipe in both directions
                  onDismissed: (direction) {
                    newsVM.removeArticle(index); // Remove from the list
                    Get.snackbar(
                      "Article Removed",
                      "You dismissed: ${article.title}",
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  secondaryBackground: Container(
                    color: Colors.blue,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(Icons.archive, color: Colors.white),
                  ),
                  child: NewsCard(article: article),
                );
              },
            ),
          );
        }
      }),
    );
  }
}
