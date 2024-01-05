import 'package:collegemitra/src/constants/colors.dart';
import 'package:collegemitra/src/features/authentication/models/all_colleges_model.dart';
import 'package:collegemitra/src/features/authentication/screens/counselling_features/features/all_colleges/widgets/about.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PlacementsTab extends StatelessWidget {
  final List<CollegeDetails> collegeDetails;
  const PlacementsTab({super.key, required this.collegeDetails});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 7),
            Placements(
                highestpackage: collegeDetails[0].highestPackage,
                averagePackage: collegeDetails[0].averagePackage),
            const SizedBox(height: 12),
            PlacementPercentage(branches: collegeDetails[0].branchesFees),
            const SizedBox(height: 10),
            Recruiters(companyImages: collegeDetails[0].companyImages),
          ],
        ),
      ),
    );
  }
}

class Logos extends StatelessWidget {
  final List<String> companyImages;

  const Logos({Key? key, required this.companyImages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: SizedBox(
                  height: 220.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: companyImages.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PhotoViewGallery.builder(
                                itemCount: companyImages.length,
                                builder: (context, index) {
                                  return PhotoViewGalleryPageOptions(
                                    imageProvider:
                                        NetworkImage(companyImages[index]),
                                    minScale:
                                        PhotoViewComputedScale.contained * 0.8,
                                    maxScale:
                                        PhotoViewComputedScale.covered * 2,
                                  );
                                },
                                scrollPhysics: const BouncingScrollPhysics(),
                                backgroundDecoration: const BoxDecoration(
                                  color: Colors.black,
                                ),
                                pageController:
                                    PageController(initialPage: index),
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              companyImages[index],
                              height: 220.0, // Adjust the width as needed
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Recruiters extends StatelessWidget {
  final List<String> companyImages;
  const Recruiters({super.key, required this.companyImages});

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
              'Recruiters',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: tPrimaryColor,
              ),
            ),
            const Divider(
              color: tPrimaryColor,
            ),
            Logos(companyImages: companyImages),
          ],
        ),
      ),
    );
  }
}

class PlacementPercentage extends StatelessWidget {
  final List<Branch> branches;

  const PlacementPercentage({Key? key, required this.branches})
      : super(key: key);

  TableRow buildTableRow(String branch, String cutoff) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              branch,
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              cutoff,
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
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
      child: Table(
        border: TableBorder.all(
          color: Colors.grey,
          width: 2,
          borderRadius: BorderRadius.circular(10),
        ),
        children: [
          const TableRow(children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Branches',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.deepPurple),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Percentage',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                      fontSize: 16),
                ),
              ),
            ),
          ]),
          for (var branch in branches)
            buildTableRow(branch.branchName, branch.percentagePlacement),
        ],
      ),
    );
  }
}
