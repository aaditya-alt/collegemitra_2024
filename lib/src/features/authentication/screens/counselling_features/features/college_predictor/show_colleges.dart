import 'package:collegemitra/src/constants/colors.dart';
import 'package:collegemitra/src/features/authentication/models/user_model.dart';
import 'package:collegemitra/src/features/authentication/screens/counselling_features/features/college_predictor/show_branches.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowColleges extends StatelessWidget {
  final List<dynamic> userDetails;
  final List<CollegeData> collegesToShow;
  final String counsellingName;

  const ShowColleges({
    Key? key,
    required this.collegesToShow,
    required this.counsellingName,
    required this.userDetails,
  });

  @override
  Widget build(BuildContext context) {
    List<String> userDetailsName = [
      "Counselling",
      "Domicile",
      "Category",
      "Sub Category",
      "JEE Mains Rank"
    ];

    final size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "$counsellingName Colleges",
        ),
        centerTitle: true,
        backgroundColor: tPrimaryColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 14,
              right: 14,
              top: 8,
              bottom: 12,
            ),
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search Colleges...",
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.filter_alt_rounded),
                    ),
                    prefixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {},
                    ),
                    contentPadding: const EdgeInsets.all(12),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          Stack(
            children: [
              Container(
                color: tPrimaryColor.shade100,
                height: 55,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Container(
                          width: 120,
                          margin: const EdgeInsets.all(4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                userDetailsName[index],
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 117, 117, 117),
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                userDetails[index],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Text(
                          "|\n|\n|",
                          style: TextStyle(color: tPrimaryColor),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: size - 45),
                child: Container(
                  width: 45,
                  height: 55,
                  decoration: const BoxDecoration(
                    color: tPrimaryColor,
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.edit_document,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Container(
            color: const Color.fromARGB(255, 204, 204, 204),
            height: 40,
            child: ListView.builder(
              itemCount: 4,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 90,
                      margin: const EdgeInsets.all(4),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              "All Colleges (18)",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Text(
                      "|\n|\n|",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
              itemCount: collegesToShow.length,
              itemBuilder: (context, index) {
                var college = collegesToShow[index];
                final isEvenIndex = index.isEven;

                return ListTile(
                  tileColor: isEvenIndex ? Colors.grey.shade200 : Colors.white,
                  title: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: const Center(
                          child: Text(
                            "🎓",
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              college.collegeName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "${college.branches.length} Branches",
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 90,
                            padding: const EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: const Color.fromARGB(255, 131, 131, 131),
                              ),
                            ),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.sentiment_satisfied,
                                  size: 35,
                                  color: Colors.green,
                                ),
                                Flexible(
                                  child: Text(
                                    "80% Chance",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 5),
                          GestureDetector(
                            child: const Icon(
                              Icons.keyboard_arrow_right,
                              color: tPrimaryColor,
                              size: 30,
                            ),
                            onTap: () {
                              Get.to(() => ShowBranches(
                                    branchesToShow: college.branches,
                                    counsellingName: counsellingName,
                                    userDetails: userDetails,
                                    collegeName: college.collegeName,
                                  ));
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
