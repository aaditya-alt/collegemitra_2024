import 'package:carousel_slider/carousel_slider.dart';
import 'package:collegemitra/src/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class BottomCarousel extends StatefulWidget {
  const BottomCarousel({super.key});

  @override
  State<BottomCarousel> createState() => _BottomCarouselState();
}

class _BottomCarouselState extends State<BottomCarousel> {
  late YoutubePlayerController _controller;
  bool _isPlayerReady = false;
  List<String> youtubeVideoIds = [];
  int currentIndex = 0;

  List<String> youtubeVideoLinks = [];

  @override
  void initState() {
    initializeYoutube();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> initializeYoutube() async {
    youtubeVideoLinks = await getYoutubeVideoLinks("FOOTER");
    youtubeVideoIds = convertLinksToIds(youtubeVideoLinks);
    setState(() {}); // Trigger a rebuild to update the CarouselSlider
  }

  List<String> convertLinksToIds(List<String> videoLinks) {
    List<String> videoIds = [];
    for (String link in videoLinks) {
      String videoId = YoutubePlayer.convertUrlToId(link) ?? '';
      if (videoId.isNotEmpty) {
        videoIds.add(videoId);
      }
    }
    return videoIds;
  }

  @override
  Widget build(BuildContext context) {
    if (youtubeVideoIds.isEmpty) {
      return const SizedBox(
        height: 160,
        width: double.infinity,
        child: Center(
          child: CircularProgressIndicator(
            color: tPrimaryColor,
          ), // Show loading indicator while fetching data
        ),
      );
    }

    return CarouselSlider.builder(
      itemCount: youtubeVideoIds.length,
      options: CarouselOptions(
        height: 140,
        aspectRatio: 16 / 9,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: false,
        onPageChanged: (index, reason) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      itemBuilder: (BuildContext context, int index, int realIndex) {
        return GestureDetector(
          onTap: () {
            _playVideo(youtubeVideoIds[index]);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.network(
                    'https://img.youtube.com/vi/${youtubeVideoIds[index]}/0.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: const Icon(
                      Icons.play_circle_outline,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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

Future<List<String>> getYoutubeVideoLinks(String position) async {
  final supabase = Supabase.instance.client;
  final response = await supabase
      .from("header_footer_video")
      .select("video_link")
      .eq("position", position);

  final List<dynamic>? data = response is List ? response : response['data'];

  if (data == null || data.isEmpty) {
    // Return an empty list if there is no data
    return [];
  }

  final List<String> youtubeVideoLinks =
      data.map((row) => row['video_link'].toString()).toList();

  return youtubeVideoLinks;
}
