import 'package:collegemitra/src/constants/colors.dart';
import 'package:flutter/material.dart';

class PromoCard extends StatelessWidget {
  const PromoCard({
    Key? key,
    this.counselling_name,
  }) : super(key: key);

  static const kDefaultShadow = BoxShadow(
    offset: Offset(0, 15),
    blurRadius: 27,
    color: Colors.black12, // Black color with 12% opacity
  );

  final counselling_name;

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height / 4.5,
      child: InkWell(
        onTap: () {},
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: size.height / 4.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: tPrimaryColor,
                boxShadow: const [kDefaultShadow],
              ),
              child: Container(
                height: size.height / 5.5,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: isDark ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Hero(
                tag: '1',
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: size.height / 4.5,
                  child: Image.asset(
                    'assets/images/dashboard_images/graduation.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 4,
              bottom: 0,
              left: 0,
              child: SizedBox(
                height: size.height / 5,
                width: size.width / 2.5,
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
                            : 'Need Guidance ?',
                        style: Theme.of(context).textTheme.headlineMedium,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20 * 1.5,
                        vertical: 20 / 4,
                      ),
                      decoration: const BoxDecoration(
                        color: tAccentColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(22),
                          topRight: Radius.circular(22),
                        ),
                      ),
                      child: Text(
                        "₹399",
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.white),
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
