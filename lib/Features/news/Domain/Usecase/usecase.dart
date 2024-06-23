import 'package:dartz/dartz.dart';
import 'package:newsapp/Features/news/Data/model/models.dart';
import 'package:newsapp/Features/news/Domain/Repository/repositrory.dart';

class GetTopHeadlines {
  final NewsRepository repository;

  GetTopHeadlines(this.repository);

  Future<Either<Exception, List<News>>> call(String category) async {
    return await repository.getTopHeadlines(category);
  }
}
