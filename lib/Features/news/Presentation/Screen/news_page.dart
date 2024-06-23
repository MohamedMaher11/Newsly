import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Features/news/Data/model/category.dart';
import 'package:newsapp/Features/news/Data/model/models.dart';
import 'package:newsapp/Features/news/Presentation/Screen/category.dart';
import 'package:newsapp/Features/news/Presentation/Screen/news_details.dart';
import 'package:card_swiper/card_swiper.dart';
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
  List<Map<String, dynamic>> swiperData = [];
  late List<News> news = [];

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
          news = newsByCategory[_selectedCategory] ?? [];
          swiperData = news.map((article) {
            return {
              'title': article.title,
              'imageUrl': article.urlToImage,
            };
          }).toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 40),
              Container(
                height: 160,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: swiperData.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : Swiper(
                        itemBuilder: (BuildContext context, int index) {
                          String title = swiperData[index]['title'];
                          String imageUrl = swiperData[index]['imageUrl'] ?? '';
                          News article = news[index];

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      NewsDetailPage(news: article),
                                ),
                              );
                            },
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: imageUrl.isNotEmpty
                                          ? Image.network(
                                              imageUrl,
                                              fit: BoxFit.cover,
                                            )
                                          : Container(
                                              color: Colors.grey[300],
                                              child: Center(
                                                child: Text(
                                                  'No Image Available',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: swiperData.length,
                        viewportFraction: 0.8,
                        scale: 0.9,
                        autoplay: true,
                        autoplayDelay: 5000,
                        control: SwiperControl(color: Colors.transparent),
                      ),
              ),
              SizedBox(height: 40),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.6,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 70,
                  ),
                  itemCount: widget.categories.length,
                  itemBuilder: (context, index) {
                    final category = widget.categories[index];

                    // Hardcoded list of images for demonstration
                    List<String> images = [
                      'assets/5.png',
                      'assets/6.png',
                      'assets/4.jpg',
                      'assets/2.jpg',
                      'assets/3.jpg',
                      'assets/1.jpg',
                    ];

                    String selectedImage = images[index % images.length];

                    return Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  NewsCategoryPage(category: category.category),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                              image: AssetImage(selectedImage),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black.withOpacity(0.3),
                                  Colors.black.withOpacity(0.7),
                                ],
                              ),
                            ),
                            child: Center(
                              child: Text(
                                category.categoryName,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
