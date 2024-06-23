import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Features/news/Data/model/category.dart';
import 'package:newsapp/Features/news/Data/model/models.dart';
import 'package:newsapp/Features/news/Presentation/Screen/NewsPages/grid.dart';
import 'package:newsapp/Features/news/Presentation/Screen/NewsPages/swiper.dart';
import 'package:newsapp/Features/news/Presentation/Screen/searchpage.dart';
import 'package:newsapp/Features/news/Presentation/cubit/cubit.dart';

class NewsPage extends StatefulWidget {
  final List<CategoryModel> categories;

  NewsPage({required this.categories});

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  String _selectedCategory = 'science';

  @override
  void initState() {
    super.initState();
    context
        .read<NewsCubit>()
        .fetchTopHeadlinesForAllCategories(widget.categories);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('News feed')),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchPage()),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<NewsCubit, Map<String, List<News>>>(
        builder: (context, newsByCategory) {
          List<News> news = newsByCategory[_selectedCategory] ?? [];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 40),
              NewsSwiper(news: news),
              SizedBox(height: 40),
              CategoryGrid(
                  categories: widget
                      .categories), // Corrected usage of CategoryGrid widget
            ],
          );
        },
      ),
    );
  }
}
