import 'package:collegemitra/src/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:collegemitra/src/utils/theme/widget_themes/text_theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PopularBlogs extends StatefulWidget {
  String counsellingName = "POPULAR";
  PopularBlogs({super.key, required this.counsellingName});

  @override
  State<PopularBlogs> createState() => _PopularBlogsState();
}

class _PopularBlogsState extends State<PopularBlogs> {
  List<blogSection> blogDetails = [];
  @override
  void initState() {
    _getData();
    super.initState();
  }

  void _getData() async {
    blogDetails = await getDataFromDatabase(widget.counsellingName);
    // Set isLoading to false after fetching data
    setState(() {}); // Trigger a rebuild
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    if (blogDetails.isEmpty) {
      return const SizedBox(
        height: 200,
        width: 180,
        child: Center(
          child: CircularProgressIndicator(
            color: tPrimaryColor,
          ), // Show loading indicator while fetching data
        ),
      );
    }
    return SizedBox(
      height: 200,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: blogDetails.length,
          itemBuilder: (BuildContext context, int i) => GestureDetector(
                child: Card(
                  elevation: 3,
                  color: isDark
                      ? Colors.black
                      : const Color.fromARGB(255, 255, 229, 238),
                  child: Container(
                    height: 200,
                    width: 180,
                    decoration: BoxDecoration(
                        color: isDark
                            ? Colors.black
                            : const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(10),
                            top: Radius.circular(10))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          alignment: Alignment.center,
                          width: 180,
                          height: 100,
                          child: Image.network(
                            blogDetails[i].image,
                            fit: BoxFit.cover,
                            width: 180,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          blogDetails[i].title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          textAlign: TextAlign.center,
                          blogDetails[i].subTitle,
                          style: TextStyle(
                            fontSize: 13,
                            color: isDark ? Colors.white : Colors.black,
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

Future<List<blogSection>> getDataFromDatabase(String counselling) async {
  final supabase = Supabase.instance.client;
  final response =
      await supabase.from("blogs_card").select().eq("counselling", counselling);

  final List<dynamic>? data = response is List ? response : response['data'];

  if (data == null || data.isEmpty) {
    return [];
  }

  final List<blogSection> blogsDetails = data
      .map<blogSection>((row) => blogSection(
            image: row['image_link'].toString(),
            title: row['title'].toString(),
            subTitle: row['sub_title'].toString(),
          ))
      .toList();

  return blogsDetails;
}
