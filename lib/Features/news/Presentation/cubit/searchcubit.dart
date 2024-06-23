import 'package:bloc/bloc.dart';
import 'package:newsapp/Features/news/Data/model/models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:newsapp/core/constant/apikey.dart';

class SearchCubit extends Cubit<List<News>> {
  SearchCubit() : super([]);

  void performSearch(String query) async {
    if (query.isNotEmpty) {
      String apiKey = NewsApi; // Replace with your News API key
      String url = 'https://newsapi.org/v2/everything?q=$query&apiKey=$apiKey';

      try {
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          Map<String, dynamic> responseData = json.decode(response.body);
          List<dynamic> articles = responseData['articles'];

          List<News> fetchedNews = articles.map((article) {
            return News(
              title: article['title'] ?? '',
              urlToImage: article['urlToImage'] ?? '',
              url: article['url'] ?? '',
              content: article['content'] ?? '',
              description: article['description'] ?? '',
              author: article['author'] ?? '',
              publishedAt: article['publishedAt'] ?? '',
            );
          }).toList();

          emit(fetchedNews);
        } else {
          throw Exception('Failed to load search results');
        }
      } catch (e) {
        print('Error fetching search results: $e');
      }
    }
  }
}
