import 'package:dartz/dartz.dart';
import 'package:newsapp/Features/news/Data/model/models.dart';

abstract class NewsRepository {
  Future<Either<Exception, List<News>>> getTopHeadlines(String category);
  Future<Either<Exception, List<News>>> searchNews(String query,
      {DateTime? from, DateTime? to});
}
