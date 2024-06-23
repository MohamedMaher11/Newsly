import 'package:flutter/material.dart';
import 'package:newsapp/Features/news/Data/model/category.dart';
import 'package:newsapp/Features/news/Presentation/Screen/category.dart';

class CategoryGrid extends StatelessWidget {
  final List<CategoryModel> categories;

  CategoryGrid({required this.categories});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.6,
          crossAxisSpacing: 20,
          mainAxisSpacing: 70,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];

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
    );
  }
}
