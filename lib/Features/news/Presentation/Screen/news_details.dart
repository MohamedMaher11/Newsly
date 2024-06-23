import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/Features/news/Data/model/models.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailPage extends StatelessWidget {
  final News news;

  NewsDetailPage({required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(news.title ?? 'News Detail'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          if (news.urlToImage != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                news.urlToImage!,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          SizedBox(height: 16),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    news.title ?? '',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  if (news.publishedAt != null)
                    Text(
                      DateFormat.yMMMMd()
                          .format(DateTime.parse(news.publishedAt!)),
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  SizedBox(height: 16),
                  if (news.content != null)
                    Text(
                      news.content ?? '',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                      child: Text(
                        "Show Full Article",
                        style: TextStyle(fontSize: 15, color: Colors.blue),
                      ),
                      onTap: () {
                        _launchUrl(news.url!);
                      })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
