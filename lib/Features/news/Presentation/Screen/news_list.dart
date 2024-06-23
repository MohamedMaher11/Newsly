import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/Features/news/Data/model/models.dart';
import 'package:newsapp/Features/news/Presentation/Screen/news_details.dart';

class NewsList extends StatefulWidget {
  final List<News> news;

  NewsList({required this.news});

  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: widget.news.length,
            itemBuilder: (context, index) {
              final article = widget.news[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewsDetailPage(news: article),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _buildArticleImage(article),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                _buildArticleTitle(article),
                                SizedBox(height: 4),
                                _buildArticleDate(article),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
  }

  Widget _buildArticleImage(News article) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 100,
        height: 100,
        color: Colors.grey[200],
        child: article.urlToImage != null
            ? Image.network(
                article.urlToImage!,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              )
            : Icon(Icons.image, size: 50, color: Colors.grey),
      ),
    );
  }

  Widget _buildArticleTitle(News article) {
    return Text(
      article.title ?? '',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildArticleDate(News article) {
    return Row(
      children: <Widget>[
        Icon(Icons.calendar_today, color: Colors.grey[600], size: 16),
        SizedBox(width: 4),
        Text(
          DateFormat.yMMMMd().format(
            DateTime.parse(article.publishedAt ?? ''),
          ),
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchData(); // Call your method to fetch data here
  }

  void _fetchData() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate fetching data delay
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });
  }
}
