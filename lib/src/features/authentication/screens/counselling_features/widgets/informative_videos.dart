import 'package:collegemitra/src/constants/colors.dart';
import 'package:collegemitra/src/features/authentication/screens/video_player/information_youtube_video.dart';
import 'package:flutter/material.dart';
import 'package:collegemitra/src/utils/theme/widget_themes/text_theme.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class InformativeVideos extends StatefulWidget {
  final counsellingName;
  const InformativeVideos({super.key, required this.counsellingName});

  @override
  State<InformativeVideos> createState() => _InformativeVideosState();
}

class _InformativeVideosState extends State<InformativeVideos> {
  late PageController pageController;
  List<VideoCard> videoCards = [];
  List<String> youtubeVideoIds = [];

  @override
  void initState() {
    super.initState();
    initializeYoutube();
    pageController = PageController(viewportFraction: 0.8);
  }

  Future<void> initializeYoutube() async {
    videoCards = await getDataFromDatabase(widget.counsellingName);
    youtubeVideoIds = convertLinksToIds(videoCards);
    setState(() {}); // Trigger a rebuild to update the CarouselSlider
  }

  List<String> convertLinksToIds(List<VideoCard> videoCards) {
    List<String> videoIds = [];

    for (int i = 0; i < videoCards.length; i++) {
      String videoId =
          YoutubePlayer.convertUrlToId(videoCards[i].videoURL) ?? '';
      if (videoId.isNotEmpty) {
        videoIds.add(videoId);
      }
    }

    return videoIds;
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    if (videoCards.isEmpty) {
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
      height: 228,
      width: 200,
      child: ListView.builder(
          controller: pageController,
          scrollDirection: Axis.horizontal,
          itemCount: videoCards.length,
          itemBuilder: (BuildContext context, int i) => Card(
                elevation: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: 160,
                          width: 300,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15)),
                            child: Image.network(
                              'https://img.youtube.com/vi/${youtubeVideoIds[i]}/hqdefault.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Get.to(YoutubeVideoPlayer(
                            videoURL: videoCards[i].videoURL,
                          )),
                          child: Icon(
                            Icons.play_circle_fill_rounded,
                            color: isDark ? Colors.white : Colors.black,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, bottom: 8.0, right: 0),
                      child: Row(children: [
                        Text(
                          videoCards[i].title,
                          style: Theme.of(context).textTheme.titleMedium,
                          softWrap: true,
                          selectionColor: isDark ? Colors.white : Colors.black,
                        ),
                        // const SizedBox(width: 30),
                        // Text(
                        //   videoCards[i].time_in_ago,
                        //   style: Theme.of(context).textTheme.bodySmall,
                        // ),
                      ]),
                    ),
                  ],
                ),
              )),
    );
  }
}

class VideoCard {
  final String videoURL;
  final String title;
  VideoCard({
    required this.videoURL,
    required this.title,
  });
}

Future<List<VideoCard>> getDataFromDatabase(String counselling) async {
  final supabase = Supabase.instance.client;
  final response = await supabase
      .from("testimonials")
      .select()
      .eq("counselling", counselling);

  final List<dynamic>? data = response is List ? response : response['data'];

  if (data == null || data.isEmpty) {
    return [];
  }

  final List<VideoCard> videoCardDetails = data
      .map<VideoCard>((row) => VideoCard(
            videoURL: row['video_link'].toString(),
            title: row['title'].toString(),
          ))
      .toList();

  return videoCardDetails;
}
