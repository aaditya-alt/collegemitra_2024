import 'dart:ui';
import 'package:collegemitra/src/constants/colors.dart';
import 'package:collegemitra/src/features/authentication/models/all_colleges_model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ShowAllColleges extends StatefulWidget {
  final String counselling = "JOSAA";
  const ShowAllColleges({super.key});

  @override
  State<ShowAllColleges> createState() => _ShowAllCollegesState();
}

class _ShowAllCollegesState extends State<ShowAllColleges> {
  bool isLoading = false;
  List<AllColleges> collegeDetails = [];

  @override
  void initState() {
    isLoading = true;
    _getData();
    super.initState();
  }

  void _getData() async {
    await Future.delayed(const Duration(microseconds: 500));
    collegeDetails = await getAllColleges(widget.counselling);
    // Set isLoading to false after fetching data
    setState(() {
      isLoading = false;
    }); // Trigger a rebuild
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tAccentColor,
        title: const Text(
          "All Colleges",
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
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
              AllCollegesList(
                collegeList: collegeDetails,
              ),
            ],
          ),
          Visibility(
            visible: isLoading,
            child: Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: Image.asset(
                  "assets/gif/loader.gif",
                  width: size.width / 4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<List<AllColleges>> getAllColleges(String counselling) async {
    final supabase = Supabase.instance.client;
    final response = await supabase
        .from("college_details")
        .select()
        .eq("counselling", counselling);

    final List<dynamic>? data = response is List ? response : response['data'];

    if (data == null || data.isEmpty) {
      return [];
    }

    final List<AllColleges> allCollegesdetails = data
        .map<AllColleges>((row) => AllColleges(
              collegeName: row['full_name'].toString(),
              collegeState: row['state'].toString(),
              collegeType: row['type'].toString(),
              collegeImage: row['main_image'].toString(),
            ))
        .toList();

    return allCollegesdetails;
  }
}

class AllCollegesList extends StatelessWidget {
  final List<AllColleges> collegeList;
  const AllCollegesList({
    super.key,
    required this.collegeList,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Expanded(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: collegeList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                child: Card(
                  borderOnForeground: true,
                  color: Colors.white,
                  surfaceTintColor: Colors.white,
                  elevation: 4,
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width - 20,
                              height: MediaQuery.of(context).size.height / 4,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    topRight: Radius.circular(25)),
                              ),
                              child: Image.network(
                                collegeList[index].collegeImage,
                                fit: BoxFit.cover,
                              )),
                          Positioned.fill(
                              child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                      sigmaX: 30, sigmaY: 30))),
                          Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 5.4,
                                left: 10),
                            child: Text(
                              collegeList[index].collegeName,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              const SizedBox(height: 7),
                              const Text(
                                "Type",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 121, 121, 121)),
                              ),
                              Text(
                                collegeList[index].collegeType,
                                style: const TextStyle(
                                    color: tPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 7),
                            ],
                          ),
                          const SizedBox(width: 20),
                          Column(
                            children: [
                              const SizedBox(height: 7),
                              const Text(
                                "State",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                collegeList[index].collegeState,
                                style: const TextStyle(
                                    color: tPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 7),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
