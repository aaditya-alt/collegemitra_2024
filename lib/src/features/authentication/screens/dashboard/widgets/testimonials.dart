import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TestimonialSection extends StatelessWidget {
  const TestimonialSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // ignore: non_constant_identifier_names
    final List<Testimonial> Testimonials = [
      Testimonial(
          image: 'assets/images/profile_images/profile-image.jpeg',
          name: 'Aaditya Ranjan',
          college: 'GJUS&T Hisar',
          branch: 'CSE(AI&ML)',
          review:
              'I am a tech enthusiast now, but that was not always the case. I come from a non-tech background and used to.',
          color: const Color.fromARGB(255, 0, 208, 255)),
      Testimonial(
          image: 'assets/images/profile_images/profile-image.jpeg',
          name: 'Aaditya Ranjan',
          college: 'GJUS&T Hisar',
          branch: 'CSE(AI&ML)',
          review:
              'I am a tech enthusiast now, but that was not always the case. I come from a non-tech background and used to.',
          color: const Color.fromARGB(255, 255, 0, 187)),
      Testimonial(
          image: 'assets/images/profile_images/profile-image.jpeg',
          name: 'Aaditya Ranjan',
          college: 'GJUS&T Hisar',
          branch: 'CSE(AI&ML)',
          review:
              'I am a tech enthusiast now, but that was not always the case. I come from a non-tech background and used to.',
          color: const Color.fromARGB(255, 212, 255, 0)),
      Testimonial(
          image: 'assets/images/profile_images/profile-image.jpeg',
          name: 'Aaditya Ranjan',
          college: 'GJUS&T Hisar',
          branch: 'CSE(AI&ML)',
          review:
              'I am a tech enthusiast now, but that was not always the case. I come from a non-tech background and used to.',
          color: const Color.fromARGB(255, 255, 132, 0)),
    ];
    return SizedBox(
      height: size.height / 3,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: Testimonials.length,
          itemBuilder: (BuildContext context, int i) => SizedBox(
                width: size.width - 10,
                child: Card(
                  surfaceTintColor: Testimonials[i].color,
                  elevation: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 60, top: 20),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 24,
                              foregroundImage:
                                  AssetImage(Testimonials[i].image),
                            ),
                            const SizedBox(width: 15),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  Testimonials[i].name,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                Text(
                                  '${Testimonials[i].college}, ${Testimonials[i].branch}',
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(255, 92, 92, 92)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                          height: 18,
                          width: 25,
                          child: Padding(
                            padding:
                                EdgeInsets.only(left: 18, top: 15, bottom: 0),
                            child: Icon(Icons.format_quote_sharp),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20, left: 22, right: 20, bottom: 20),
                        child: Text(
                          Testimonials[i].review,
                          textAlign: TextAlign.start,
                        ),
                      )
                    ],
                  ),
                ),
              )),
    );
  }
}

class Testimonial {
  final String image;
  final String name;
  final String college;
  final String branch;
  final String review;
  final Color color;
  Testimonial({
    required this.image,
    required this.name,
    required this.college,
    required this.branch,
    required this.review,
    required this.color,
  });
}
