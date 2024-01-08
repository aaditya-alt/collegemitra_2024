import 'package:cached_network_image/cached_network_image.dart';
import 'package:collegemitra/src/constants/colors.dart';
import 'package:collegemitra/src/features/authentication/models/blog_section_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PopularBlogs extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final counsellingName;
  const PopularBlogs({super.key, required this.counsellingName});

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
    try {
      blogDetails = await getDataFromDatabase(widget.counsellingName);

      setState(() {});
    } catch (error) {
      // Handle the error (e.g., log it or show a user-friendly message)
      debugPrint("Error fetching data: $error");
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (blogDetails.isEmpty) {
      return const SizedBox(
        height: 200,
        width: 180,
        child: Center(
          child: CircularProgressIndicator(
            color: tPrimaryColor,
          ),
        ),
      );
    }
    return SizedBox(
      height: 240,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: blogDetails.length,
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(width: 8), // Add separator width
        itemBuilder: (BuildContext context, int i) => GestureDetector(
          child: newBlogsCard(
            context,
            blogDetails[i].title,
            blogDetails[i].subTitle,
            widget.counsellingName,
            blogDetails[i].image,
          ),
        ),
      ),
    );
  }
}

getDataFromDatabase(String counselling) async {
  try {
    final supabase = Supabase.instance.client;
    final response = await supabase
        .from("blogs_card")
        .select()
        .eq("counselling", counselling);

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
  } catch (e) {
    Get.snackbar(
      'Error',
      'Something went wrong. Try again',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent.withOpacity(0.1),
      colorText: Colors.red,
    );
  }
}

Widget newBlogsCard(BuildContext context, String title, String subTitle,
    String counselling, String image) {
  var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
  return // Generated code for this Container Widget...
      Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
    child: Container(
      width: MediaQuery.sizeOf(context).width * 0.5,
      decoration: BoxDecoration(
        color: isDark ? Colors.black12 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            color: Color(0x3F14181B),
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(4, 4, 4, 12),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: image,
                  width: double.infinity,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 4),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    counselling,
                    style: const TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      color: Color(0xFF57636C),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
              child: Text(
                title,
                style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    color: isDark
                        ? const Color.fromARGB(255, 215, 214, 214)
                        : const Color(0xFF14181B),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(8, 4, 0, 0),
              child: Text(
                subTitle,
                style: const TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    color: Color(0xFF57636C),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
