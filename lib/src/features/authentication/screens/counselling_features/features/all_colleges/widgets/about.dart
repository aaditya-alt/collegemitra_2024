import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ImageSection(),
          _buildCollegeInformation(),
        ],
      ),
    );
  }

  Widget _buildCollegeInformation() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Introduction(),
          Connectivity(),
          Placements(),
          Hostel(),
          Facilities(),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}

class Hostel extends StatelessWidget {
  const Hostel({super.key});

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
      elevation: 4,
      color: Colors.white,
      child: const Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hostel',
              style: TextStyle(
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(1.0, 1.0),
                    blurRadius: 2.0,
                    color: Colors.black,
                  ),
                ],
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),
            Divider(
              color: Colors.deepOrange,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      "Boys Hostel",
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    Text(
                      "₹ 43,600",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Girls Hostel",
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    Text(
                      "₹ 39,200",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
            Text(
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
  const ImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              "assets/NITW.jpg",
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
              alignment: Alignment.bottomCenter,
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
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: const Text(
                "National Institute of Technology Warangal",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Connectivity extends StatelessWidget {
  const Connectivity({super.key});

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
      elevation: 4,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Connectivity',
              style: TextStyle(
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(1.0, 1.0),
                    blurRadius: 2.0,
                    color: Colors.black,
                  ),
                ],
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),
            const Divider(
              color: Colors.deepOrange,
            ),
            const SizedBox(width: 5),
            RichText(
              textAlign: TextAlign.justify,
              text: const TextSpan(
                children: [
                  WidgetSpan(
                    child: Icon(
                      Icons.airplanemode_active,
                      color: Colors.deepPurple,
                      size: 15,
                    ),
                  ),
                  TextSpan(
                    text: "  Nearby Airport: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                      fontSize: 15,
                    ),
                  ),
                  TextSpan(
                    text:
                        "Rajiv Gandhi International Airport, Hyderabad. The airport is approximately 150 km away from the college.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            RichText(
              textAlign: TextAlign.justify,
              text: const TextSpan(
                children: [
                  WidgetSpan(
                    child: Icon(
                      Icons.train,
                      color: Colors.deepPurple,
                      size: 15,
                    ),
                  ),
                  TextSpan(
                    text: " Nearby Railway Station: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                      fontSize: 15,
                    ),
                  ),
                  TextSpan(
                    text:
                        "Kazipet Junction. The railway station is approximately 15 km away from the college.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
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

class Placements extends StatelessWidget {
  const Placements({super.key});

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
      elevation: 4,
      color: Colors.white,
      child: const Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Placement Overview',
              style: TextStyle(
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(1.0, 1.0),
                    blurRadius: 2.0,
                    color: Colors.black,
                  ),
                ],
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),
            Divider(
              color: Colors.deepOrange,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      "Highest package",
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    Text(
                      "₹ 40 Lacs",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Average package",
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    Text(
                      "₹ 15 Lacs",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
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
  const Introduction({super.key});

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
      elevation: 4,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Introduction',
              style: TextStyle(
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(1.0, 1.0),
                    blurRadius: 2.0,
                    color: Colors.black,
                  ),
                ],
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),
            const Divider(
              color: Colors.deepOrange,
            ),
            RichText(
              textAlign: TextAlign.justify,
              text: const TextSpan(
                text:
                    'NIT Warangal is a premier engineering institution located in Warangal, Telangana, India. It was formerly known as Regional Engineering College, Warangal (REC Warangal).',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: "Founded: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                      fontSize: 15,
                    ),
                  ),
                  TextSpan(
                    text: "1959",
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            RichText(
              textAlign: TextAlign.justify,
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: "Ranking: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                      fontSize: 15,
                    ),
                  ),
                  TextSpan(
                    text:
                        "NIT Warangal is consistently ranked among the top engineering colleges in India.",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
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

class Facilities extends StatelessWidget {
  const Facilities({super.key});

  Widget createFacilityWidget(String imagePath, String label) {
    return SizedBox(
      width: 80,
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

  Widget createFacilityRow(List<Map<String, String>> facilities) {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: facilities.map((facility) {
          return createFacilityWidget(
              facility['imagePath']!, facility['label']!);
        }).toList(),
      ),
    );
  }

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
      elevation: 4,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Facilities',
              style: TextStyle(
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(1.0, 1.0),
                    blurRadius: 2.0,
                    color: Colors.black,
                  ),
                ],
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),
            const Divider(
              color: Colors.deepOrange,
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
            ]),
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
            ]),
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
            ]),
          ],
        ),
      ),
    );
  }
}
