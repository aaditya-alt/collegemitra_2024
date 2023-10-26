import 'package:collegemitra/src/constants/colors.dart';
import 'package:collegemitra/src/features/authentication/screens/video_player/information_youtube_video.dart';
import 'package:flutter/material.dart';
import 'package:collegemitra/src/utils/theme/widget_themes/text_theme.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class InformativeVideos extends StatefulWidget {
  const InformativeVideos({super.key});

  @override
  State<InformativeVideos> createState() => _InformativeVideosState();
}

class _InformativeVideosState extends State<InformativeVideos> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.8);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    List<videoCard> videoCards = [
      videoCard(
          video_url: 'https://youtu.be/TF0To2vWNa8?si=wOypWFNgaT00UMcE',
          title_text:
              'HSTES Physical Counselling का पूरा निचोड़\n बस एक वीडियो में । Premium Google Meet',
          time_in_ago: '2 months ago',
          video_id: 'TF0To2vWNa8'),
      videoCard(
          video_url: 'https://youtu.be/I79DcXLCGfE?si=JeFLUOM14kGRLQIL',
          title_text:
              'Get the Best Govt. Engineering College On\n Your JEE Mains Rank 2023 | Collegemitra',
          time_in_ago: '2 months ago',
          video_id: 'I79DcXLCGfE'),
      videoCard(
          video_url: 'https://youtu.be/pC-zjH3-yL4?si=ok4ZO0x7v7pkdfmS',
          title_text:
              'OJEE Counselling 2023 Started | Odisha\n BTech Counselling 2023 | Collegemitra',
          time_in_ago: '2 months ago',
          video_id: 'pC-zjH3-yL4'),
    ];

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
                              'https://img.youtube.com/vi/${videoCards[i].video_id}/hqdefault.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Get.to(YoutubeVideoPlayer(
                            videoURL: videoCards[i].video_url,
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
                          videoCards[i].title_text,
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

class videoCard {
  final String video_url;
  final String title_text;
  final String time_in_ago;
  final String video_id;
  videoCard({
    required this.video_url,
    required this.title_text,
    required this.time_in_ago,
    required this.video_id,
  });
}
