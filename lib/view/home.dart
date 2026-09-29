import 'package:flutter/material.dart';
import 'widget/news_container.dart';
import 'package:news_app/controller/fetchNews.dart';
import 'package:news_app/model/newsArt.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<NewsArticle>> _newsFuture;

  @override
  void initState() {
    super.initState();
    _newsFuture = FetchNews.fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Top Headlines'), centerTitle: true),
      body: FutureBuilder<List<NewsArticle>>(
        future: _newsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final articles = snapshot.data ?? [];

          if (articles.isEmpty) {
            return const Center(child: Text('No articles found'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final article = articles[index];

              final imageUrl = article.urlToImage.isNotEmpty
                  ? article.urlToImage
                  : 'https://via.placeholder.com/400x200.png?text=No+Image';
              final title = article.title.isNotEmpty
                  ? article.title
                  : 'No title';
              final description = article.description.isNotEmpty
                  ? article.description
                  : 'No description available.';
              final source = 'Source'; // adjust when you add sourceName
              final articleUrl = article.url;

              return NewsContainer(
                imageUrl: imageUrl,
                title: title,
                description: description,
                source: source,
                articleUrl: articleUrl,
              );
            },
          );
        },
      ),
    );
  }
}
