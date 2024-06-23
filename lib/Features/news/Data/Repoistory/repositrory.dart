import 'package:dartz/dartz.dart';
import 'package:newsapp/Features/news/Data/model/models.dart';
import 'package:newsapp/Features/news/Data/Service/service.dart';
import 'package:newsapp/Features/news/Domain/Repository/repositrory.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;

  NewsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Exception, List<News>>> getTopHeadlines(String category) async {
    try {
      final remoteNews = await remoteDataSource.getTopHeadlines(category);
      return Right(remoteNews.cast<News>());
    } catch (exception) {
      return Left(Exception('Failed to load news'));
    }
  }

  @override
  Future<Either<Exception, List<News>>> searchNews(String query,
      {DateTime? from, DateTime? to}) async {
    try {
      final remoteNews =
          await remoteDataSource.searchNews(query, from: from, to: to);
      return Right(remoteNews.cast<News>());
    } catch (exception) {
      return Left(Exception('Failed to search news'));
    }
  }
}
