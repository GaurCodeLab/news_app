import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/news_article.dart';

/// A stateless widget that represents a news card.
/// 
/// This widget is used to display a news article with relevant information
/// such as the title, description, and image.
/// 
/// The [NewsCard] widget is typically used within a list or grid to display
/// multiple news articles in a structured format.
class NewsCard extends StatelessWidget {
  final NewsArticle article;

  const NewsCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/details', arguments: article);
      },
      child: Card(
        margin: EdgeInsets.all(8),
        child: ListTile(
          leading:
              article.imageUrl.isNotEmpty
                  ? Image.network(
                    article.imageUrl,
                    width: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(width: 100, color: Colors.grey);
                    },
                  )
                  : Container(width: 100, color: Colors.grey),
          title: Text(
            article.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            article.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
