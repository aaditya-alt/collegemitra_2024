import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MyCarouselSlider extends StatefulWidget {
  const MyCarouselSlider({Key? key}) : super(key: key);

  @override
  State<MyCarouselSlider> createState() => _MyCarouselSliderState();
}

class _MyCarouselSliderState extends State<MyCarouselSlider> {
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

  void initializeYoutube() async {
    youtubeVideoLinks = await getYoutubeVideoLinks("HEADER");
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
      // Handle the case where youtubeVideoIds is empty
      return const Center(
        child: Text("No YouTube videos available"),
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
        enlargeCenterPage: true,
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
