import 'package:bloc/bloc.dart';
import 'package:newsapp/Features/news/Data/model/category.dart';

import 'package:newsapp/Features/news/Data/model/models.dart';
import 'package:newsapp/Features/news/Domain/Usecase/search.dart';
import 'package:newsapp/Features/news/Domain/Usecase/usecase.dart';

class NewsCubit extends Cubit<Map<String, List<News>>> {
  final GetTopHeadlines getTopHeadlines;
  final SearchNews searchNews;

  NewsCubit(this.getTopHeadlines, this.searchNews) : super({});

  void fetchTopHeadlinesForAllCategories(List<CategoryModel> categories) async {
    Map<String, List<News>> newsByCategory = {};
    for (var category in categories) {
      final result = await getTopHeadlines(category.category);
      result.fold(
        (exception) => print(exception),
        (news) => newsByCategory[category.category] = news,
      );
    }
    emit(newsByCategory);
  }
}
