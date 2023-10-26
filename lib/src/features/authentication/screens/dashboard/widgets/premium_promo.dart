import 'package:flutter/material.dart';

class PromoCard extends StatelessWidget {
  const PromoCard({
    super.key,
    this.counselling_name,
  });

  static const kDefaultShadow = BoxShadow(
    offset: Offset(0, 15),
    blurRadius: 27,
    color: Colors.black12, // Black color with 12% opacity
  );
  final counselling_name;
  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    // It  will provide us total height and width of our screen
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      // color: Colors.blueAccent,
      height: 160,
      child: InkWell(
        onTap: () {},
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // Those are our background
            Container(
              height: 136,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: const Color(0xFF40BAD5),
                boxShadow: const [kDefaultShadow],
              ),
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: isDark ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
            ),
            // our product image
            Positioned(
              top: 0,
              right: 0,
              child: Hero(
                tag: '1',
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: 160,
                  // image is square but we add extra 20 + 20 padding thats why width is 200
                  width: 200,
                  child: Image.asset(
                    'assets/images/dashboard_images/graduation.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // Product title and price
            Positioned(
              bottom: 0,
              left: 0,
              child: SizedBox(
                height: 136,
                // our image take 200 width, thats why we set out total width - 200
                width: size.width - 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        (counselling_name != null &&
                                counselling_name != 'JAC Delhi' &&
                                counselling_name != 'GGSIPU Delhi')
                            ? '$counselling_name Mentorship ?'
                            : 'Looking for Mentorship ?',
                        style: Theme.of(context).textTheme.titleLarge,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    // it use the available space
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20 * 1.5, // 30 padding
                        vertical: 20 / 4, // 5 top and bottom
                      ),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFA41B),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(22),
                          topRight: Radius.circular(22),
                        ),
                      ),
                      child: Text(
                        "\$399",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
