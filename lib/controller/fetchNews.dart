import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/model/newsArt.dart'; // adjust path if needed

class FetchNews {
  // static List<String> sourcesID = [
  //   "abc-news",
  //   "bbc-news",
  //   "bbc-sport",
  //   "business-insider",
  //   "engadget",
  //   "entertainment-weekly",
  //   "espn",
  //   "espn-cric-info",
  //   "financial-post",
  //   "fox-news",
  //   "fox-sports",
  //   "globo",
  //   "google-news",
  //   "google-news-in",
  //   "medical-news-today",
  //   "national-geographic",
  //   "news24",
  //   "new-scientist",
  //   "new-york-magazine",
  //   "next-big-future",
  //   "techcrunch",
  //   "techradar",
  //   "the-hindu",
  //   "the-wall-street-journal",
  //   "the-washington-times",
  //   "time",
  //   "usa-today",
  // ];

  static Future<List<NewsArticle>> fetchNews() async {
    //final sourceID = (List<String>.from(sourcesID)..shuffle()).first;

    final uri = Uri.https('newsapi.org', '/v2/top-headlines', {
      'country': 'us',
      'category': 'general',
      'apiKey': '81fe4f3fbfa94269bfce53fce8be4e02', // your key
    });

    final response = await http.get(uri);

    // DEBUG LOGS:
    print('NewsAPI status: ${response.statusCode}');
    print('NewsAPI body: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> bodyData = jsonDecode(response.body);
      final List<dynamic> articlesJson = bodyData['articles'] ?? [];

      return articlesJson
          .map((a) => NewsArticle.fromJson(a as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to load news: ${response.statusCode}');
    }
  }
}
