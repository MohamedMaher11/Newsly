import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Features/news/Data/Repoistory/repositrory.dart';
import 'package:newsapp/Features/news/Data/Service/service.dart';
import 'package:newsapp/Features/news/Data/model/category.dart';
import 'package:newsapp/Features/news/Domain/Usecase/search.dart';
import 'package:newsapp/Features/news/Domain/Usecase/usecase.dart';
import 'package:newsapp/Features/news/Presentation/Screen/NewsPages/new_page.dart';
import 'package:newsapp/Features/news/Presentation/cubit/cubit.dart';
import 'package:newsapp/Features/news/Presentation/cubit/searchcubit.dart';
import 'package:newsapp/core/api/dio_consumer.dart';
import 'package:newsapp/core/constant/apikey.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final newsRemoteDataSource = NewsRemoteDataSourceImpl(
    apiConsumer: DioConsumer(dio: Dio()),
    apiKey: NewsApi,
  );
  final newsRepository =
      NewsRepositoryImpl(remoteDataSource: newsRemoteDataSource);
  final getTopHeadlines = GetTopHeadlines(newsRepository);
  final searchNews = SearchNews(newsRepository);

  List<CategoryModel> categories = getCategories();

  runApp(MyApp(
    getTopHeadlines: getTopHeadlines,
    searchNews: searchNews,
    categories: categories,
  ));
}

class MyApp extends StatelessWidget {
  final GetTopHeadlines getTopHeadlines;
  final SearchNews searchNews;
  final List<CategoryModel> categories;

  MyApp({
    required this.getTopHeadlines,
    required this.searchNews,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchCubit>(
          create: (context) => SearchCubit(),
        ),
        BlocProvider(
          create: (_) => NewsCubit(getTopHeadlines, searchNews)
            ..fetchTopHeadlinesForAllCategories(categories),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News App',
        theme: ThemeData.dark(),
        home: NewsPage(categories: categories),
      ),
    );
  }
}
