import 'package:carousel_slider/carousel_slider.dart';
import 'package:collegemitra/src/constants/colors.dart';
import 'package:collegemitra/src/features/authentication/screens/counselling_features/features/college_predictor/college_predictor.dart';
import 'package:collegemitra/src/features/authentication/screens/counselling_features/widgets/informative_videos.dart';
import 'package:collegemitra/src/features/authentication/screens/dashboard/dashboard_screen.dart';
import 'package:collegemitra/src/features/authentication/screens/dashboard/widgets/blogs_section.dart';
import 'package:collegemitra/src/features/authentication/screens/dashboard/widgets/bottom_carousel.dart';
import 'package:collegemitra/src/features/authentication/screens/dashboard/widgets/counselling_buttons.dart';
import 'package:collegemitra/src/features/authentication/screens/dashboard/widgets/counselling_list_items.dart';
import 'package:collegemitra/src/features/authentication/screens/dashboard/widgets/premium_promo.dart';
import 'package:collegemitra/src/features/authentication/screens/general_utils/carousel_slider.dart';
import 'package:collegemitra/src/features/authentication/screens/general_utils/drawer_header.dart';
import 'package:collegemitra/src/features/authentication/screens/general_utils/drawer_list.dart';
import 'package:collegemitra/src/features/authentication/screens/meeting/meeting_home_screen.dart';
import 'package:collegemitra/src/features/authentication/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FeatureScreen extends StatefulWidget {
  final String appBarTitle;
  const FeatureScreen({super.key, required this.appBarTitle});

  @override
  State<FeatureScreen> createState() => _FeatureScreenState();
}

class _FeatureScreenState extends State<FeatureScreen> {
  bool isLoading = false;
  late YoutubePlayerController _controller;
  bool _isPlayerReady = false;
  List<String> youtubeVideoIds = [
    'SEzIoNqJL3U',
    'pYYBGnanhzM',
    'SEzIoNqJL3U',
  ];

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<CustomIcon> featureIcons_1 = [
      CustomIcon(
        icon: "assets/images/dashboard_images/3d-target.png",
        name: "Know About",
        counselling: widget.appBarTitle,
      ),
      CustomIcon(
        icon: "assets/images/dashboard_images/search.png",
        name: "Predictor",
        counselling: widget.appBarTitle,
      ),
      CustomIcon(
        icon: "assets/images/dashboard_images/chart.png",
        name: "Predict Rank",
        counselling: widget.appBarTitle,
      ),
      CustomIcon(
        icon: "assets/images/dashboard_images/office.png",
        name: "Branch",
        counselling: widget.appBarTitle,
      ),
    ];
    List<CustomIcon> featureIcons_2 = [
      CustomIcon(
          icon: "assets/images/dashboard_images/justice.png",
          name: "Comparison"),
      CustomIcon(
          icon: "assets/images/dashboard_images/seats.png",
          name: "Seat Matrix"),
      CustomIcon(
          icon: "assets/images/dashboard_images/benchmarking.png",
          name: "College List"),
      CustomIcon(
          icon: "assets/images/dashboard_images/ranking.png",
          name: "All Colleges"),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tAccentColor,
        title: Text(widget.appBarTitle.length <= 5
            ? '${widget.appBarTitle} Counselling'
            : widget.appBarTitle),
        centerTitle: true,
        actions: [
          IconButton(
              padding: const EdgeInsets.only(right: 8),
              onPressed: () {},
              icon: const Icon(
                Icons.paid_rounded,
                color: Colors.white,
              )),
        ],
      ),

      //Body of the Counselling features screen page
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(14.0),
            children: [
              const MyCarouselSlider(),
              const SizedBox(height: 20),
              Text(
                "Counselling Tools",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text("Hands on these tools to know the Process...",
                  style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 20),
              //counsellings
              CounsellingButton(listItems: featureIcons_1),
              const SizedBox(height: 20),
              CounsellingButton(listItems: featureIcons_2),
              const SizedBox(height: 30),

              PromoCard(counselling_name: widget.appBarTitle),
              const SizedBox(height: 30),

              Text(
                "Related Videos",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                  'Watch the latest video on ${widget.appBarTitle} Counselling...',
                  style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 18),

              //Related videos
              InformativeVideos(
                counsellingName: widget.appBarTitle,
              ),

              const SizedBox(height: 25),

              //Related Blogs
              Text(
                "Explore Blogs",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                  'Check out the latest blogs on ${widget.appBarTitle} Counselling...',
                  style: Theme.of(context).textTheme.bodySmall),

              const SizedBox(height: 20),

              //Popular Blogs
              PopularBlogs(counsellingName: widget.appBarTitle),

              const SizedBox(height: 20),

              const BottomCarousel(),

              //Bottom carousel
            ],
          ),
          Visibility(
            visible: isLoading,
            child: Container(
              color:
                  Colors.black.withOpacity(0.5), // Adjust the opacity as needed
              child: Center(
                child: Image.asset(
                  "assets/gif/loader.gif",
                  width: size.height / 4,
                ),
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: tAccentColor.shade100,
          elevation: 1,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: tPrimaryColor,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: 0,
          onTap: (index) {
            if (index == 3) {
              Get.to(() => const ProfileScreen());
            } else if (index == 2) {
              Get.offAll(() => const MeetingHomeScreen());
            } else if (index == 0) {
              Get.offAll(const Dashboard());
            }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.newspaper_rounded), label: "Blogs"),
            BottomNavigationBarItem(
                icon: Icon(Icons.card_membership), label: "Premium"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ]),
    );
  }

  void _playVideo(String videoId) async {
    // Initialize the controller asynchronously
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    );

    // Show the dialog only after the controller is ready
    showDialog(
      context: context,
      builder: (context) {
        return SizedBox(
          width: double.infinity,
          child: AlertDialog(
            elevation: 4,
            content: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.blue,
              onReady: () {
                _isPlayerReady = true;
              },
            ),
            contentPadding: const EdgeInsets.all(0),
            actions: [
              TextButton(
                onPressed: () {
                  _controller.pause(); // Pause the video when closing
                  Navigator.pop(context);
                },
                child: const Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }
}
