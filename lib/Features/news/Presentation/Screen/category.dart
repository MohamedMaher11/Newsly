import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Features/news/Data/model/models.dart';
import 'package:newsapp/Features/news/Presentation/Screen/news_list.dart';
import 'package:newsapp/Features/news/Presentation/cubit/cubit.dart';

class NewsCategoryPage extends StatelessWidget {
  final String category;

  NewsCategoryPage({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<NewsCubit, Map<String, List<News>>>(
        builder: (context, newsByCategory) {
          List<News> news = newsByCategory[category] ?? [];
          return NewsList(news: news);
        },
      ),
    );
  }
}
