import 'package:newsapp/Features/news/Data/model/models.dart';
import 'package:newsapp/core/api/api_consumer.dart';

abstract class NewsRemoteDataSource {
  Future<List<News>> getTopHeadlines(String category);
  Future<List<News>> searchNews(String query, {DateTime? from, DateTime? to});
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final ApiConsumer apiConsumer;
  final String apiKey;

  NewsRemoteDataSourceImpl({required this.apiConsumer, required this.apiKey});

  @override
  Future<List<News>> getTopHeadlines(String category) async {
    try {
      final response = await apiConsumer.get(
          'https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=$apiKey');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = response.data;
        final List<dynamic> articles = jsonResponse['articles'];
        return articles.map((article) => News.fromJson(article)).toList();
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      throw Exception('Failed to load news');
    }
  }

  @override
  Future<List<News>> searchNews(String query,
      {DateTime? from, DateTime? to}) async {
    try {
      String url = 'https://newsapi.org/v2/everything?q=$query&apiKey=$apiKey';
      if (from != null) {
        url += '&from=${from.toIso8601String()}';
      }
      if (to != null) {
        url += '&to=${to.toIso8601String()}';
      }
      final response = await apiConsumer.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = response.data;
        final List<dynamic> articles = jsonResponse['articles'];
        return articles.map((article) => News.fromJson(article)).toList();
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      throw Exception('Failed to load news');
    }
  }
}
