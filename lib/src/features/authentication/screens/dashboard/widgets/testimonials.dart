import 'package:cached_network_image/cached_network_image.dart';
import 'package:collegemitra/src/constants/colors.dart';
import 'package:collegemitra/src/features/authentication/models/testimonial_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TestimonialSection extends StatefulWidget {
  final counsellingName;
  const TestimonialSection({super.key, required this.counsellingName});

  @override
  State<TestimonialSection> createState() => _TestimonialSectionState();
}

class _TestimonialSectionState extends State<TestimonialSection> {
  // late Box<List<Testimonial>> testimonialBox;
  List<Testimonial> testimonialsDetails = [];
  @override
  void initState() {
    // testimonialBox = Hive.box<List<Testimonial>>('testimonialDetails');
    _getData();
    super.initState();
  }

  // void _getDataFromCache() {
  //   final cachedData = testimonialBox.get('testimonialDetails');
  //   if (cachedData == null || cachedData.isEmpty) {
  //     // If cache is empty or data is not available, fetch data from the database
  //     _getData();
  //   } else {
  //     // If cache is not empty, display data from cache
  //     setState(() {
  //       testimonialsDetails = cachedData;
  //     });
  //   }
  // }

  void _getData() async {
    try {
      testimonialsDetails = await getDataFromDatabase(widget.counsellingName);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (testimonialsDetails.isEmpty) {
      return SizedBox(
        height: size.height / 3.2,
        width: size.width - 20,
        child: const Center(
          child: CircularProgressIndicator(
            color: tPrimaryColor,
          ), // Show loading indicator while fetching data
        ),
      );
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height / 2.9,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: testimonialsDetails.length,
        itemBuilder: (BuildContext context, int i) => SizedBox(
            child: Row(
          children: [
            const SizedBox(width: 15),
            newTestimonialCard(
                testimonialsDetails[i].name,
                testimonialsDetails[i].image,
                testimonialsDetails[i].designation,
                testimonialsDetails[i].review,
                context),
          ],
        )),
      ),
    );
  }
}

getDataFromDatabase(String counselling) async {
  try {
    final supabase = Supabase.instance.client;
    final response = await supabase
        .from("testimonials")
        .select()
        .eq("counselling", counselling);

    final List<dynamic>? data = response is List ? response : response['data'];

    if (data == null || data.isEmpty) {
      return [];
    }

    final List<Testimonial> testimonialsDetails = data
        .map<Testimonial>((row) => Testimonial(
              image: row['image_link'].toString(),
              name: row['name'].toString(),
              designation: row['designation'].toString(),
              review: row['comment'].toString(),
            ))
        .toList();

    return testimonialsDetails;
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

Widget newTestimonialCard(String name, String image, String designation,
    String review, BuildContext context) {
  var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
  return Container(
    padding: const EdgeInsets.all(8),
    height: MediaQuery.of(context).size.height / 3.1,
    width: MediaQuery.of(context).size.width / 1.17,
    decoration: BoxDecoration(
      color: isDark ? const Color.fromARGB(255, 10, 10, 10) : Colors.white,
      boxShadow: const [
        BoxShadow(
          blurRadius: 4,
          color: Color(0x3F14181B),
          offset: Offset(0, 3),
        )
      ],
      borderRadius: BorderRadius.circular(8),
    ), // Adjust the width based on your design
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 0,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 4),
            child: Text(
              review,
              style: TextStyle(
                fontFamily: 'Readex Pro',
                color: isDark
                    ? const Color.fromARGB(255, 196, 196, 196)
                    : const Color(0xFF57636C),
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 4),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: image,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontFamily: 'Readex Pro',
                      color: isDark
                          ? const Color.fromARGB(255, 255, 255, 255)
                          : const Color(0xFF14181B),
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    designation,
                    style: const TextStyle(
                      fontFamily: 'Readex Pro',
                      color: Color(0xFF57636C),
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
