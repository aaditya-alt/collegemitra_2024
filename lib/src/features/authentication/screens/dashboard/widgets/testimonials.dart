import 'package:collegemitra/src/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TestimonialSection extends StatefulWidget {
  String counsellingName = "POPULAR";
  TestimonialSection({super.key, required this.counsellingName});

  @override
  State<TestimonialSection> createState() => _TestimonialSectionState();
}

class _TestimonialSectionState extends State<TestimonialSection> {
  List<Testimonial> testimonialsDetails = [];
  @override
  void initState() {
    _getData();
    super.initState();
  }

  void _getData() async {
    testimonialsDetails = await getDataFromDatabase(widget.counsellingName);
    // Set isLoading to false after fetching data
    setState(() {}); // Trigger a rebuild
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
      height: size.height / 3.2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: testimonialsDetails.length,
        itemBuilder: (BuildContext context, int i) => SizedBox(
          width: size.width - 40,
          child: Card(
            color: const Color.fromARGB(255, 255, 195, 178),
            elevation: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        foregroundImage:
                            NetworkImage(testimonialsDetails[i].image),
                      ),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            testimonialsDetails[i].name,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            testimonialsDetails[i].designation,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 92, 92, 92),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 18,
                  child: Padding(
                    padding: EdgeInsets.only(left: 18, top: 15),
                    child: Icon(Icons.format_quote_sharp),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 22,
                    right: 20,
                    bottom: 20,
                  ),
                  child: Text(
                    testimonialsDetails[i].review,
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
        ),
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
