import 'package:dartz/dartz.dart';
import 'package:newsapp/Features/news/Data/model/models.dart';
import 'package:newsapp/Features/news/Domain/Repository/repositrory.dart';

class SearchNews {
  final NewsRepository repository;

  SearchNews(this.repository);

  Future<Either<Exception, List<News>>> call(String query,
      {DateTime? from, DateTime? to}) async {
    return await repository.searchNews(query, from: from, to: to);
  }
}
