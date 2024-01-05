import 'package:cached_network_image/cached_network_image.dart';
import 'package:collegemitra/src/constants/colors.dart';
import 'package:collegemitra/src/features/authentication/models/all_colleges_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  final List<CollegeDetails> collegeDetails;
  const AboutPage({super.key, required this.collegeDetails});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageSection(
              collegeImage: collegeDetails[0].collegeImage,
              collegeName: collegeDetails[0].collegeFullName),
          _buildCollegeInformation(),
        ],
      ),
    );
  }

  Widget _buildCollegeInformation() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Introduction(
              description: collegeDetails[0].description,
              foundedIn: collegeDetails[0].foundedIn,
              ranking: collegeDetails[0].ranking,
              address: collegeDetails[0].address),
          const SizedBox(height: 10),
          Connectivity(
              nearbyAirport: collegeDetails[0].nearbyAirport,
              nearbyBus: collegeDetails[0].nearbyBus,
              nearbyRailway: collegeDetails[0].nearbyRailway),
          const SizedBox(height: 10),
          ContactDetails(
              email: collegeDetails[0].email,
              phone: collegeDetails[0].phone,
              website: collegeDetails[0].website),
          const SizedBox(height: 10),
          Hostel(
              boysHostelFee: collegeDetails[0].boysHostelFee,
              girlsHostelFee: collegeDetails[0].girlsHostelFee),
          const SizedBox(height: 10),
          const Facilities(),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class Hostel extends StatelessWidget {
  final String boysHostelFee;
  final String girlsHostelFee;
  const Hostel(
      {super.key, required this.boysHostelFee, required this.girlsHostelFee});

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isDark
            ? const Color.fromARGB(255, 10, 10, 10)
            : const Color.fromARGB(255, 245, 245, 245),
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            color: Color(0x3F14181B),
            offset: Offset(0, 3),
          )
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hostel',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: tPrimaryColor,
              ),
            ),
            const Divider(
              color: tPrimaryColor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Text(
                      "Boys Hostel",
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    Text(
                      boysHostelFee,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      "Girls Hostel",
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    Text(
                      girlsHostelFee,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
            const Text(
              "*The given fees are on yearly basis",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class ImageSection extends StatelessWidget {
  final String collegeImage;
  final String collegeName;
  const ImageSection(
      {super.key, required this.collegeImage, required this.collegeName});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: collegeImage,
              height: 200, // Adjust the height as needed
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 170,
              alignment: Alignment.bottomLeft,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(1),
                    Colors.transparent,
                    Colors.transparent,
                  ],
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10)
                  .copyWith(left: 8, right: size.width * 0.25),
              child: Text(
                collegeName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Connectivity extends StatelessWidget {
  final String nearbyAirport;
  final String nearbyRailway;
  final String nearbyBus;
  const Connectivity(
      {super.key,
      required this.nearbyAirport,
      required this.nearbyBus,
      required this.nearbyRailway});

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isDark
            ? const Color.fromARGB(255, 10, 10, 10)
            : const Color.fromARGB(255, 245, 245, 245),
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            color: Color(0x3F14181B),
            offset: Offset(0, 3),
          )
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Connectivity',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: tPrimaryColor,
              ),
            ),
            const Divider(
              color: tPrimaryColor,
            ),
            const SizedBox(width: 5),
            RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(
                children: [
                  const WidgetSpan(
                    child: Icon(
                      Icons.airplanemode_active,
                      color: Colors.deepPurple,
                      size: 15,
                    ),
                  ),
                  const TextSpan(
                    text: " Nearby Airport: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                      fontSize: 15,
                    ),
                  ),
                  TextSpan(
                    text: nearbyAirport,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(
                children: [
                  const WidgetSpan(
                    child: Icon(
                      Icons.train,
                      color: Colors.deepPurple,
                      size: 15,
                    ),
                  ),
                  const TextSpan(
                    text: " Nearby Railway Station: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                      fontSize: 15,
                    ),
                  ),
                  TextSpan(
                    text: nearbyRailway,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(
                children: [
                  const WidgetSpan(
                    child: Icon(
                      Icons.bus_alert,
                      color: Colors.deepPurple,
                      size: 15,
                    ),
                  ),
                  const TextSpan(
                    text: " Nearby Bus Stand: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                      fontSize: 15,
                    ),
                  ),
                  TextSpan(
                    text: nearbyBus,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContactDetails extends StatelessWidget {
  final String website;
  final String email;
  final String phone;

  const ContactDetails({
    Key? key,
    required this.website,
    required this.email,
    required this.phone,
  }) : super(key: key);

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isDark
            ? const Color.fromARGB(255, 10, 10, 10)
            : const Color.fromARGB(255, 245, 245, 245),
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            color: Color(0x3F14181B),
            offset: Offset(0, 3),
          )
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Contact Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: tPrimaryColor,
              ),
            ),
            const Divider(
              color: tPrimaryColor,
            ),
            const SizedBox(width: 5),
            buildLink("Website", Icons.browser_updated, website),
            const SizedBox(height: 10),
            buildLink("E-Mail ID", Icons.email, "mailto:$email"),
            const SizedBox(height: 10),
            buildLink("Contact No", Icons.phone, "tel:$phone"),
          ],
        ),
      ),
    );
  }

  Widget buildLink(String label, IconData icon, String link) {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        children: [
          WidgetSpan(
            child: Icon(
              icon,
              color: Colors.deepPurple,
              size: 15,
            ),
          ),
          TextSpan(
            text: " $label: ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
              fontSize: 15,
            ),
          ),
          TextSpan(
            text: link,
            style: const TextStyle(
                fontSize: 14,
                color: Colors.blue, // Set your preferred link color
                decoration: TextDecoration.underline,
                overflow: TextOverflow.ellipsis),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                _launchURL(link);
              },
          ),
        ],
      ),
    );
  }
}

class Placements extends StatelessWidget {
  final String highestpackage;
  final String averagePackage;
  const Placements(
      {super.key, required this.highestpackage, required this.averagePackage});

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isDark
            ? const Color.fromARGB(255, 10, 10, 10)
            : const Color.fromARGB(255, 245, 245, 245),
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            color: Color(0x3F14181B),
            offset: Offset(0, 3),
          )
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Placement Overview',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: tPrimaryColor,
              ),
            ),
            const Divider(
              color: tPrimaryColor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Text(
                      "Highest package",
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    Text(
                      highestpackage,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      "Average package",
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    Text(
                      averagePackage,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Introduction extends StatelessWidget {
  final String description;
  final String foundedIn;
  final String ranking;
  final String address;

  const Introduction(
      {super.key,
      required this.description,
      required this.foundedIn,
      required this.ranking,
      required this.address});

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isDark
            ? const Color.fromARGB(255, 10, 10, 10)
            : const Color.fromARGB(255, 245, 245, 245),
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            color: Color(0x3F14181B),
            offset: Offset(0, 3),
          )
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Introduction',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: tPrimaryColor,
              ),
            ),
            const Divider(
              color: tPrimaryColor,
            ),
            RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(
                text: description,
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: "Founded: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                      fontSize: 15,
                    ),
                  ),
                  TextSpan(
                    text: foundedIn,
                    style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: "Ranking: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                      fontSize: 15,
                    ),
                  ),
                  TextSpan(
                    text: ranking,
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: "Address: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                      fontSize: 15,
                    ),
                  ),
                  TextSpan(
                    text: address,
                    style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Facilities extends StatelessWidget {
  const Facilities({super.key});

  Widget createFacilityWidget(
      String imagePath, String label, BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 4.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, height: 50),
          Text(label),
        ],
      ),
    );
  }

  Widget createFacilityRow(
      List<Map<String, String>> facilities, BuildContext context) {
    return SizedBox(
      height: 100,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: facilities.map((facility) {
            return createFacilityWidget(
                facility['imagePath']!, facility['label']!, context);
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isDark
            ? const Color.fromARGB(255, 10, 10, 10)
            : const Color.fromARGB(255, 245, 245, 245),
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            color: Color(0x3F14181B),
            offset: Offset(0, 3),
          )
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Facilities',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: tPrimaryColor,
              ),
            ),
            const Divider(
              color: tPrimaryColor,
            ),
            createFacilityRow([
              {
                "imagePath": "assets/facilities/classroom.png",
                "label": "Classroom"
              },
              {"imagePath": "assets/facilities/bank.png", "label": "Bank"},
              {
                "imagePath": "assets/facilities/auditorium.png",
                "label": "Auditorium"
              },
              {
                "imagePath": "assets/facilities/bunk-bed.png",
                "label": "Hostel"
              },
            ], context),
            createFacilityRow([
              {
                "imagePath": "assets/facilities/coffee.png",
                "label": "Cafeteria"
              },
              {
                "imagePath": "assets/facilities/computer-science.png",
                "label": "Comp. Lab"
              },
              {"imagePath": "assets/facilities/dumbbells.png", "label": "Gym"},
              {
                "imagePath": "assets/facilities/first-aid-kit.png",
                "label": "Medical"
              },
            ], context),
            createFacilityRow([
              {
                "imagePath": "assets/facilities/library.png",
                "label": "Library"
              },
              {
                "imagePath": "assets/facilities/wireless-router.png",
                "label": "Wi-Fi"
              },
              {
                "imagePath": "assets/facilities/security.png",
                "label": "Security"
              },
              {"imagePath": "assets/facilities/sports.png", "label": "Sports"},
            ], context),
          ],
        ),
      ),
    );
  }
}
