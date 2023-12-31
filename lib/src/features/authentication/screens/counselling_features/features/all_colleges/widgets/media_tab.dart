import 'package:collegemitra/src/features/authentication/models/all_colleges_model.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MediaMain extends StatelessWidget {
  final List<CollegeDetails> collegedetails;
  const MediaMain({super.key, required this.collegedetails});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          MyImageCard(collegeImages: collegedetails[0].imageUrlString),
          MyVideoCard(videoLinks: collegedetails[0].videoLinks),
        ],
      ),
    );
  }
}

class MyImageCard extends StatelessWidget {
  final List<String> collegeImages;
  final List<String> assetImagePaths = [
    'assets/campus/2.jpg',
    'assets/campus/1.jpg',
    'assets/campus/3.jpg',
    'assets/campus/4.jpg',
    'assets/campus/5.jpg',
    'assets/campus/6.jpg',
    'assets/campus/7.jpg',
    'assets/campus/8.jpg',
    'assets/campus/9.jpg',
    // Add more asset image paths as needed
  ];

  MyImageCard({super.key, required this.collegeImages});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
          style: BorderStyle.solid,
          width: 3,
          color: Colors.deepOrange,
        ),
      ),
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Images',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),
            const Divider(
              color: Colors.deepOrange,
            ),
            SizedBox(
              height: 200.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: collegeImages.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PhotoViewGallery.builder(
                            itemCount: collegeImages.length,
                            builder: (context, index) {
                              return PhotoViewGalleryPageOptions(
                                imageProvider:
                                    NetworkImage(collegeImages[index]),
                                minScale:
                                    PhotoViewComputedScale.contained * 0.8,
                                maxScale: PhotoViewComputedScale.covered * 2,
                              );
                            },
                            scrollPhysics: const BouncingScrollPhysics(),
                            backgroundDecoration: const BoxDecoration(
                              color: Colors.black,
                            ),
                            pageController: PageController(initialPage: index),
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          collegeImages[index],
                          height: 150, // Adjust the width as needed
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyVideoCard extends StatelessWidget {
  final List<String> videoLinks;
  final List<String> youtubeVideoUrls = [
    'https://youtu.be/bWoVqHpxzho?si=Hrc13kofL23aV_SY',
    'https://youtu.be/AsKFyFhvIcQ?si=3H6aLaCv1hHgjfGj',
    'https://youtu.be/iGeuCueiYgc?si=IEPw-gUBGNcmJaQg',
    'https://youtu.be/cfJ5R4uUU5s?si=AWLJ5hbAz-p_oqx3',
    'https://youtu.be/dKAl9vQvUdw?si=A0BGtKO3wOiyow66',
    // Add more YouTube video URLs as needed
  ];

  MyVideoCard({super.key, required this.videoLinks});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
          style: BorderStyle.solid,
          width: 3,
          color: Colors.deepOrange,
        ),
      ),
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Videos',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),
            const Divider(
              color: Colors.deepOrange,
            ),
            SizedBox(
              height: 200.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: videoLinks.length,
                itemBuilder: (BuildContext context, int index) {
                  final videoId =
                      YoutubePlayer.convertUrlToId(videoLinks[index]) ?? '';
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Scaffold(
                              body: Center(
                                child: YoutubePlayer(
                                  controller: YoutubePlayerController(
                                    initialVideoId: videoId,
                                    flags: const YoutubePlayerFlags(
                                      autoPlay: true,
                                      mute: false,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Container(
                            width: 300, // Adjust the width as needed
                            // height: 150.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://img.youtube.com/vi/$videoId/0.jpg'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          const Center(
                              widthFactor: 7,
                              child: Icon(
                                Icons.play_circle_fill,
                                size: 40,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
