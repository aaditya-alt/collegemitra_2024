import 'package:collegemitra/src/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TestimonialSection extends StatefulWidget {
  final counsellingName;
  const TestimonialSection({super.key, required this.counsellingName});

  @override
  State<TestimonialSection> createState() => _TestimonialSectionState();
}

class _TestimonialSectionState extends State<TestimonialSection> {
  late Box<List<Testimonial>> testimonialBox;
  List<Testimonial> testimonialsDetails = [];
  @override
  void initState() {
    testimonialBox = Hive.box<List<Testimonial>>('testimonialDetails');
    _getDataFromCache();
    super.initState();
  }

  void _getDataFromCache() {
    final cachedData = testimonialBox.get('testimonialDetails');
    if (cachedData == null || cachedData.isEmpty) {
      // If cache is empty or data is not available, fetch data from the database
      _getData();
    } else {
      // If cache is not empty, display data from cache
      setState(() {
        testimonialsDetails = cachedData;
      });
    }
  }

  void _getData() async {
    testimonialsDetails = await getDataFromDatabase(widget.counsellingName);
    // Set isLoading to false after fetching data
    setState(() {
      testimonialBox.put('testimonialDetails', testimonialsDetails);
    }); // Trigger a rebuild
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
            newTestimonialCard(
                testimonialsDetails[i].name,
                testimonialsDetails[i].image,
                testimonialsDetails[i].designation,
                testimonialsDetails[i].review,
                context),
            const SizedBox(width: 15),
          ],
        )),
      ),
    );
  }
}

class Testimonial {
  final String image;
  final String name;
  final String designation;
  final String review;
  Testimonial({
    required this.image,
    required this.name,
    required this.designation,
    required this.review,
  });
}

Future<List<Testimonial>> getDataFromDatabase(String counselling) async {
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
}

Widget newTestimonialCard(String name, String image, String designation,
    String review, BuildContext context) {
  var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
  return Container(
    padding: const EdgeInsets.all(8),
    width: MediaQuery.of(context).size.width / 1.17,
    decoration: BoxDecoration(
      color: isDark ? Colors.black : Colors.white,
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
        Row(
          children: [
            RatingBar.builder(
              onRatingUpdate: (newValue) => print(newValue),
              itemBuilder: (context, index) => const Icon(
                Icons.star_rounded,
                color: tAccentColor,
              ),
              direction: Axis.horizontal,
              initialRating: 4,
              unratedColor: const Color(0xFFE0E3E7),
              itemCount: 5,
              itemSize: 24,
              glowColor: tAccentColor,
            ),
          ],
        ),
        Expanded(
          flex: 0,
          child: Text(
            review,
            style: const TextStyle(
              fontFamily: 'Readex Pro',
              color: Color(0xFF57636C),
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                image,
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
      ],
    ),
  );
}
