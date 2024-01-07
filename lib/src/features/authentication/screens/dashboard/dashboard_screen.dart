import 'package:cached_network_image/cached_network_image.dart';
import 'package:collegemitra/src/constants/colors.dart';
import 'package:collegemitra/src/features/authentication/screens/dashboard/widgets/best_services.dart';
import 'package:collegemitra/src/features/authentication/screens/dashboard/widgets/blogs_section.dart';
import 'package:collegemitra/src/features/authentication/screens/dashboard/widgets/bottom_carousel.dart';
import 'package:collegemitra/src/features/authentication/screens/dashboard/widgets/counselling_buttons.dart';
import 'package:collegemitra/src/features/authentication/screens/dashboard/widgets/counselling_list_items.dart';
import 'package:collegemitra/src/features/authentication/screens/dashboard/widgets/premium_promo.dart';
import 'package:collegemitra/src/features/authentication/screens/dashboard/widgets/testimonials.dart';
import 'package:collegemitra/src/features/authentication/screens/dashboard/widgets/why_collegemitra.dart';
import 'package:collegemitra/src/features/authentication/screens/general_utils/carousel_slider.dart';
import 'package:collegemitra/src/features/authentication/screens/meeting/meeting_home_screen.dart';
import 'package:collegemitra/src/features/authentication/screens/premium/premium_purchase.dart';
import 'package:collegemitra/src/features/authentication/screens/profile/profile_screen.dart';
import 'package:collegemitra/src/repository/authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Dashboard extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final username;
  const Dashboard({super.key, this.username});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String imageLink = "";
  getPromotionalImage() async {
    final supabase = Supabase.instance.client;

    final response = await supabase
            .from('promotional_image')
            .select('image_link')
            .eq('counselling', 'POPULAR')
            .limit(
                1) // Limit the result to 1 row, assuming you only need one image
        ;

    final List<dynamic>? data = response is List ? response : response['data'];
    if (data != null && data.isNotEmpty) {
      imageLink = data.map((row) => row['image_link'].toString()).toString();

      imageLink = response;
    }
  }

  @override
  void initState() {
    getPromotionalImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    String firstName;

    final auth = AuthenticationRepository.instance;
    if (widget.username == null) {
      firstName = auth.userName;
    } else {
      firstName = widget.username;
    }

    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const Padding(padding: EdgeInsets.only(top: 6)),
              Text(
                "Hey $firstName",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text("How are you feeling today?",
                  style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: IconButton(
                  onPressed: () => Get.to(() => const ProfileScreen()),
                  icon: Icon(
                    Icons.notifications_active_rounded,
                    size: 28,
                    color: tAccentColor.shade300,
                  )),
            ),
          ]),
      body: ListView(
        padding: const EdgeInsets.all(12.0),
        children: [
          const SizedBox(height: 10),
          const MyCarouselSlider(),
          //upcoming card
          // const UpcomingCard(),
          const SizedBox(height: 20),
          Text(
            "Explore Mentorship",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text("Engineering Counselling and Mentorship Details...",
              style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 20),
          //counsellings
          CounsellingButton(listItems: customIcons),
          const SizedBox(height: 20),
          CounsellingButton(listItems: allCounselling),
          const SizedBox(height: 30),

          Text(
            "Best Services",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text("Try out some Free & Best Services by Us...",
              style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 15),

          //services
          const BestServices(),

          const SizedBox(height: 25),

          Text(
            "Popular Blogs",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text("Explore Counselling knowledge in Blogs...",
              style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 15),

          //Popular Blogs
          const PopularBlogs(
            counsellingName: "POPULAR",
          ),

          const SizedBox(height: 25),

          //Collegemitra premium promotion
          const PromoCard(),

          const SizedBox(
            height: 30,
          ),

          Text(
            "Our Mentorship",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text("Explore Fantastic reviews by our students...",
              style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 25),

          //Testimonial Section
          const TestimonialSection(
            counsellingName: "POPULAR",
          ),

          const SizedBox(height: 25),

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.star,
                // Replace this with the desired icon
                color: Colors.white,
                // Icon color
              ),
              label: const Text(
                'Get Premium Support',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: tPrimaryColor, // Button color

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:
                    const EdgeInsets.all(16), // Adjust the padding as needed
              ),
            ),
          ),

          const SizedBox(height: 20),

          imageLink != ""
              ? CachedNetworkImage(
                  imageUrl: imageLink,
                  width: MediaQuery.sizeOf(context).width,
                )
              : const SizedBox(height: 0),

          const SizedBox(height: 10),
          Text(
            "Why Collegemitra?",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          // Text("Explore Fantastic reviews by our students...",
          //     style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 18),

          const WhyCollegemitra(),

          const SizedBox(height: 30),

          //Bottom Corousel Slider
          const BottomCarousel(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        indicatorColor: isDark ? tPrimaryColor : tPrimaryColor.shade200,
        height: 65,
        elevation: 2,
        selectedIndex: 0,
        onDestinationSelected: (index) {
          if (index == 3) {
            Get.to(() => const ProfileScreen());
          } else if (index == 1) {
            Get.to(() => const MeetingHomeScreen());
          } else if (index == 2) {
            Get.to(() => const PremiumPurchase());
          }
        },
        destinations: const [
          NavigationDestination(icon: Icon(Iconsax.home), label: "Home"),
          NavigationDestination(icon: Icon(Iconsax.shop), label: "Store"),
          NavigationDestination(icon: Icon(Iconsax.heart), label: "Wishlist"),
          NavigationDestination(icon: Icon(Iconsax.user), label: "Profile"),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
}
