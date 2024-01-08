import 'package:cached_network_image/cached_network_image.dart';
import 'package:collegemitra/src/constants/colors.dart';
import 'package:collegemitra/src/features/authentication/models/all_colleges_model.dart';
import 'package:collegemitra/src/features/authentication/screens/counselling_features/features/all_colleges/show_college_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ShowAllColleges extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final counselling;
  const ShowAllColleges({Key? key, required this.counselling})
      : super(key: key);

  @override
  State<ShowAllColleges> createState() => _ShowAllCollegesState();
}

class _ShowAllCollegesState extends State<ShowAllColleges> {
  bool isLoading = false;
  List<AllColleges> collegeDetails = [];
  List<AllColleges> filteredColleges = [];

  String counselling = "JOSAA";

  @override
  void initState() {
    isLoading = true;
    _getData();
    super.initState();
  }

  void _getData() async {
    try {
      await Future.delayed(const Duration(milliseconds: 150));
      collegeDetails = await getAllColleges(widget.counselling);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        filteredColleges = List.from(collegeDetails);
        isLoading = false;
      });
    }

    // Set isLoading to false after fetching data

    // Trigger a rebuild
  }

  void filterColleges(String query) {
    setState(() {
      isLoading = true;
      filteredColleges = collegeDetails
          .where((college) =>
              college.collegeName.toLowerCase().contains(query.toLowerCase()))
          .toList();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
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
                      onChanged: filterColleges,
                      decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
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
              AllCollegesList(collegeList: filteredColleges),
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

  getAllColleges(String counselling) async {
    try {
      final supabase = Supabase.instance.client;
      final response = await supabase
          .from("college_details")
          .select()
          .eq("counselling", counselling);

      final List<dynamic>? data =
          response is List ? response : response['data'];

      if (data == null || data.isEmpty) {
        return [];
      }

      final List<AllColleges> allCollegesdetails = data
          .map<AllColleges>((row) => AllColleges(
                collegeName: row['full_name'].toString(),
                collegeState: row['state'].toString(),
                collegeType: row['type'].toString(),
                collegeImage: row['main_image'].toString(),
                collegeId: row['id'],
              ))
          .toList();

      return allCollegesdetails;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong. Try again',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.red,
      );
    }
  }
}

class AllCollegesList extends StatelessWidget {
  final List<AllColleges>? collegeList;
  const AllCollegesList({
    super.key,
    required this.collegeList,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    return Expanded(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: collegeList!.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => Get.to(() => ShowCollegeDetails(
                    collegeId: collegeList![index].collegeId,
                  )),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                child: Card(
                  borderOnForeground: true,
                  color: isDark
                      ? const Color.fromARGB(255, 10, 10, 10)
                      : Colors.white,
                  surfaceTintColor: isDark
                      ? const Color.fromARGB(255, 10, 10, 10)
                      : Colors.white,
                  elevation: 4,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: collegeList![index].collegeImage,
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
                              height: MediaQuery.of(context).size.height / 5,
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
                                  .copyWith(left: 9, right: size.width * 0.25),
                              child: Text(
                                collegeList![index].collegeName,
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
                                collegeList![index].collegeType,
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
                                collegeList![index].collegeState,
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
              ),
            );
          }),
    );
  }
}
