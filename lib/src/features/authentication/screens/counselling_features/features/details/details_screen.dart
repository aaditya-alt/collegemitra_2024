import 'package:collegemitra/src/constants/colors.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final counsellingName;

  const DetailsScreen({Key? key, required this.counsellingName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<TextDetail> details = [
      TextDetail(
          title: "Building Flutter App",
          desc1:
              "How do you lay out a single widget in Flutter? This sectionshows you how to create and display a simple widget.It also shows the entire code for a simple Hello World app. In Flutter, it takes only a few steps to put text, an icon,or an image on the screen.",
          desc2:
              "How do you lay out a single widget in Flutter? This sectionshows you how to create and display a simple widget.It also shows the entire code for a simple Hello World app. In Flutter, it takes only a few steps to put text, an icon,or an image on the screen.",
          desc3:
              "How do you lay out a single widget in Flutter? This sectionshows you how to create and display a simple widget.It also shows the entire code for a simple Hello World app. In Flutter, it takes only a few steps to put text, an icon,or an image on the screen."),
      TextDetail(
          title: "title", desc1: "desc1", desc2: "desc2", desc3: "desc3"),
      TextDetail(
          title: "title", desc1: "desc1", desc2: "desc2", desc3: "desc3"),
      TextDetail(
          title: "title", desc1: "desc1", desc2: "desc2", desc3: "desc3"),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tAccentColor,
        title: Text("Know About $counsellingName"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: size.height / 3,
            width: size.width,
            child: Image.asset(
              "assets/images/features_images/about.jpeg",
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 7),
          Expanded(
            child: counsellingDetailTiles(details),
          ),
        ],
      ),
    );
  }
}

Widget counsellingDetailTiles(List<TextDetail> detail) {
  return ListView.builder(
    scrollDirection: Axis.vertical,
    itemCount: detail.length,
    itemBuilder: (BuildContext context, index) => Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 226, 213).withOpacity(0.1),
      ),
      padding: const EdgeInsets.only(bottom: 8),
      child: ExpansionTile(
        title: Text(
          detail[index].title,
          style: const TextStyle(
              color: tPrimaryColor, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        collapsedBackgroundColor:
            const Color.fromARGB(255, 255, 230, 223).withOpacity(0.1),
        collapsedTextColor: tPrimaryColor,
        initiallyExpanded: true,
        tilePadding:
            const EdgeInsets.only(top: 7, bottom: 7, left: 15, right: 10),
        childrenPadding: const EdgeInsets.all(10),
        children: [
          _BulletPoint(detail[index].desc1),
          _BulletPoint(detail[index].desc2),
          _BulletPoint(detail[index].desc3),
        ],
      ),
    ),
  );
}

class _BulletPoint extends StatelessWidget {
  final String text;

  const _BulletPoint(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "•  ",
            style: TextStyle(
              color: Colors.black87,
              fontSize: 18,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TextDetail {
  final String title;
  final String desc1;
  final String desc2;
  final String desc3;
  TextDetail({
    required this.title,
    required this.desc1,
    required this.desc2,
    required this.desc3,
  });
}
