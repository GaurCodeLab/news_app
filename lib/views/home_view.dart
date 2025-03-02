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
          /// Builds a scrollable list of widgets.
          /// 
          /// This method returns a `ListView.builder` which lazily builds its children
          /// on demand. The `itemBuilder` callback is called with the context and the 
          /// index of the item to be built.
          /// 
          /// - `context`: The `BuildContext` in which the widget is built.
          /// - `index`: The index of the item to be built.
          /// 
          /// Returns a `ListView.builder` widget.
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
            /// A widget that builds a scrollable list of items.
            /// 
            /// This `ListView.builder` constructor creates a list view whose
            /// children are created on demand. This is particularly useful for
            /// lists with a large number of children because the builder is called
            /// only for those children that are actually visible.
            /// 
            /// The `itemBuilder` callback will be called with indices greater than
            /// or equal to zero and less than `itemCount`. The `itemBuilder` should
            /// always return a non-null widget, and may return different widget types
            /// for different indices.
            /// 
            /// The `itemCount` parameter specifies the number of items in the list.
            /// If `itemCount` is null, the list is infinite.
           
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
