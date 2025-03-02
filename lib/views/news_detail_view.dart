import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../models/news_article.dart';

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
