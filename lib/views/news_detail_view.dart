import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../models/news_article.dart';

/// A stateless widget that displays the details of a news article.
/// 
/// This view is used to present the full content of a selected news item,
/// including its title, image, and body text.
/// 
/// The [NewsDetailView] widget is typically navigated to from a list of news
/// articles, providing a detailed view of the selected article.
class NewsDetailView extends StatelessWidget {
   final NewsArticle article = Get.arguments;

  NewsDetailView({super.key});
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(article.title)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: article.imageUrl,
            child:
                article.imageUrl.isNotEmpty
                    ? SizedBox(
                      height: 200,
                      child: Image.network(
                        article.imageUrl,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(height: 200, color: Colors.grey);
                        },
                      ),
                    )
                    : Container(height: 200, color: Colors.grey),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(article.description, style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
