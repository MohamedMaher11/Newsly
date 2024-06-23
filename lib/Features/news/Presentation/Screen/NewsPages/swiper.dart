import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/Features/news/Data/model/models.dart';
import 'package:newsapp/Features/news/Presentation/Screen/news_details.dart';

class NewsSwiper extends StatelessWidget {
  final List<News> news;

  NewsSwiper({required this.news});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> swiperData = news.map((article) {
      return {
        'title': article.title,
        'imageUrl': article.urlToImage,
      };
    }).toList();

    return Container(
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
                        builder: (context) => NewsDetailPage(news: article),
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
    );
  }
}
