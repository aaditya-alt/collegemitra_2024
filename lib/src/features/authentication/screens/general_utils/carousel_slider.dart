import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MyCarouselSlider extends StatefulWidget {
  const MyCarouselSlider({Key? key}) : super(key: key);

  @override
  State<MyCarouselSlider> createState() => _MyCarouselSliderState();
}

class _MyCarouselSliderState extends State<MyCarouselSlider> {
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
    return Container(
      child: CarouselSlider.builder(
        itemCount: youtubeVideoIds.length,
        options: CarouselOptions(
          height: 185,
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
      ),
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
        return AlertDialog(
          content: SizedBox(
            height: 200,
            width: double.infinity,
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.blue,
              onReady: () {
                _isPlayerReady = true;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _controller.pause(); // Pause the video when closing
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
