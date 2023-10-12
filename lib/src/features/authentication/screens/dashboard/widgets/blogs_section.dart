import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PopularBlogs extends StatelessWidget {
  const PopularBlogs({super.key});

  @override
  Widget build(BuildContext context) {
    final List<blogSection> blogsSection = [
      blogSection(
          image: 'assets/images/dashboard_images/t10delhi.jpg',
          title: 'Colleges in Delhi',
          subTitle: 'Get to know about Top 10 Colleges in Delhi'),
      blogSection(
          image: 'assets/images/dashboard_images/counselling_images/josaa.png',
          title: 'JOSAA Counselling',
          subTitle: 'Read the article for details about JOSAA'),
      blogSection(
          image: 'assets/images/dashboard_images/t10delhi.jpg',
          title: 'College Predictor',
          subTitle: 'How to Use College Predictor Effectively'),
    ];
    return SizedBox(
      height: 200,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: blogsSection.length,
          itemBuilder: (BuildContext context, int i) => GestureDetector(
                child: Card(
                  child: Container(
                    height: 200,
                    width: 180,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(10))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 0),
                          alignment: Alignment.center,
                          width: 180,
                          height: 100,
                          child: Image.asset(
                            blogsSection[i].image,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          blogsSection[i].title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          textAlign: TextAlign.center,
                          blogsSection[i].subTitle,
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
    );
  }
}

class blogSection {
  final String image;
  final String title;
  final String subTitle;
  blogSection({
    required this.image,
    required this.title,
    required this.subTitle,
  });
}
