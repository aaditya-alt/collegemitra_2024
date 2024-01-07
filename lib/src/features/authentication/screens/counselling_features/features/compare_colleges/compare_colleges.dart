import 'package:cached_network_image/cached_network_image.dart';
import 'package:collegemitra/src/constants/colors.dart';
import 'package:collegemitra/src/features/authentication/models/all_colleges_model.dart';
import 'package:collegemitra/src/features/authentication/screens/counselling_features/features/compare_colleges/show_compare_parameters.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CompareColleges extends StatefulWidget {
  final String counsellingName;
  const CompareColleges({super.key, required this.counsellingName});

  @override
  State<CompareColleges> createState() => _CompareCollegesState();
}

class _CompareCollegesState extends State<CompareColleges> {
  bool firstCollegeSelected = false;
  String firstSelectedCollegeName = "";
  String firstSelectedImage = "";
  int firstCollegeId = 0;
  List<CollegeDetails> firstCollegeDetails = [];
  bool isLoading = false;
  bool secondCollegeSelected = false;
  String secondSelectedCollegeName = "";
  String secondSelectedImage = "";
  int secondCollegeId = 0;
  List<CollegeDetails> secondCollegeDetails = [];

  List<collegeCompare> allColleges = [];

  @override
  void initState() {
    isLoading = true;
    getAllcolleges();
    super.initState();
  }

  void getAllcolleges() async {
    final data = await getColleges(widget.counsellingName);

    allColleges = data;

    setState(() {
      isLoading = false;
    });
  }

  void getCollegeCompareParameters(int collegeId, callBack) async {
    final data = await getCollegeDetailsList(collegeId);
    callBack(data);
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: isDark
          ? const Color.fromARGB(255, 19, 19, 19)
          : const Color(0xFFF1F4F8),
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        automaticallyImplyLeading: false,
        leading: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            Get.back();
          },
          child: Icon(
            Icons.chevron_left_rounded,
            color: isDark ? Colors.white : const Color(0xFF14181B),
            size: 32,
          ),
        ),
        title: Text(
          '${widget.counsellingName} College Comparison',
          style: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            color: isDark ? Colors.white : const Color(0xFF14181B),
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: SafeArea(
        top: true,
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          fadeInDuration: const Duration(milliseconds: 100),
                          fadeOutDuration: const Duration(milliseconds: 100),
                          imageUrl:
                              'https://kclsmsgznxxrnboeopjw.supabase.co/storage/v1/object/public/college_images/public/Purple%20and%20Blue%20Gradient%20Modern%203D%20Illusrtative%20Creative%20Marketing%20Agency%20Banner%20(2).png',
                          width: MediaQuery.sizeOf(context).width,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20, 16, 0, 0),
                          child: Text(
                            "College Comparison",
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              color: isDark
                                  ? Colors.white
                                  : const Color(0xFF14181B),
                              fontSize: 24,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(20, 8, 0, 0),
                          child: Text(
                            widget.counsellingName,
                            style: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: isDark
                                  ? const Color.fromARGB(255, 169, 160, 254)
                                  : const Color(0xFF4B39EF),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20, 12, 20, 4),
                          child: Text(
                            'The best of all 3 worlds, Row & Flow offers high intensity rowing and strength intervals followed by athletic based yoga sure to enhance flexible and clear the mind.',
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              color: isDark
                                  ? const Color.fromARGB(255, 178, 176, 176)
                                  : const Color(0xFF57636C),
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        const Divider(
                          height: 24,
                          thickness: 2,
                          indent: 20,
                          endIndent: 20,
                          color: Color(0xFFE0E3E7),
                        ),
                        ListView(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10, 0, 10, 8),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: isDark ? Colors.black : Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 3,
                                      color: Color(0x2F1D2429),
                                      offset: Offset(0, 1),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      13, 9, 13, 9),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(12),
                                            child: InkWell(
                                              onTap: () =>
                                                  bottomSheetToShowColleges(
                                                context,
                                                isDark,
                                                allColleges,
                                                secondSelectedCollegeName,
                                                (name, image, id) {
                                                  setState(() {
                                                    firstCollegeSelected = true;
                                                    firstSelectedCollegeName =
                                                        name;
                                                    firstSelectedImage = image;
                                                    firstCollegeId = id;
                                                  });
                                                },
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 78,
                                                    height: 78,
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                          0x4D9489F5),
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                        color: const Color(
                                                            0xFF6F61EF),
                                                        width: 2,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl: firstCollegeSelected
                                                              ? firstSelectedImage
                                                              : 'https://shivchhatrapaticollege.org/wp-content/plugins/elementor/assets/images/placeholder.png',
                                                          width: 90,
                                                          height: 90,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            0, 4, 0, 0),
                                                    child: Text(
                                                      firstCollegeSelected
                                                          ? firstSelectedCollegeName
                                                          : "Select College",
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Plus Jakarta Sans',
                                                        color: isDark
                                                            ? Colors.white
                                                            : const Color(
                                                                0xFF14181B),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      maxLines: 3,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Stack(
                                            alignment:
                                                const AlignmentDirectional(
                                                    0, 0),
                                            children: [
                                              Align(
                                                alignment:
                                                    const AlignmentDirectional(
                                                        0, 0),
                                                child: Container(
                                                  width: 100,
                                                  height: 4,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xFFE5E7EB),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 44,
                                                height: 44,
                                                decoration: const BoxDecoration(
                                                  color: Color(0xFFE5E7EB),
                                                  shape: BoxShape.circle,
                                                ),
                                                alignment:
                                                    const AlignmentDirectional(
                                                        0, 0),
                                                child: const Icon(
                                                  Icons
                                                      .keyboard_double_arrow_right_rounded,
                                                  color: Color(0xFF606A85),
                                                  size: 32,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(12),
                                            child: InkWell(
                                              onTap: () =>
                                                  bottomSheetToShowColleges(
                                                context,
                                                isDark,
                                                allColleges,
                                                firstSelectedCollegeName,
                                                (name, image, id) {
                                                  setState(() {
                                                    secondCollegeSelected =
                                                        true;
                                                    secondSelectedCollegeName =
                                                        name;
                                                    secondSelectedImage = image;
                                                    secondCollegeId = id;
                                                  });
                                                },
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 78,
                                                    height: 78,
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                          0x4D9489F5),
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                        color: const Color(
                                                            0xFF6F61EF),
                                                        width: 2,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl: secondCollegeSelected
                                                              ? secondSelectedImage
                                                              : 'https://shivchhatrapaticollege.org/wp-content/plugins/elementor/assets/images/placeholder.png',
                                                          width: 90,
                                                          height: 90,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            0, 4, 0, 0),
                                                    child: Text(
                                                      secondCollegeSelected
                                                          ? secondSelectedCollegeName
                                                          : "Select College",
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Plus Jakarta Sans',
                                                        color: isDark
                                                            ? Colors.white
                                                            : const Color(
                                                                0xFF14181B),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      maxLines: 3,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                  child: SizedBox(
                    width: 300,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        firstCollegeSelected
                            ? secondCollegeSelected
                                ? {
                                    getCollegeCompareParameters(firstCollegeId,
                                        (value) {
                                      setState(() {
                                        firstCollegeDetails = value;
                                      });
                                      debugPrint(
                                          "First College parameters : ${firstCollegeDetails[0].campusArea}");
                                    }),
                                    getCollegeCompareParameters(secondCollegeId,
                                        (value) {
                                      setState(() {
                                        secondCollegeDetails = value;
                                      });
                                      debugPrint(
                                          "Second College parameters : ${secondCollegeDetails[0].campusArea}");
                                    }),
                                    Get.to(() => CompareParameters(
                                        firstCollegedata: firstCollegeDetails,
                                        secondCollegedata:
                                            secondCollegeDetails)),
                                  }
                                : null
                            : null;
                      },
                      style: ButtonStyle(
                        padding: const MaterialStatePropertyAll(
                          EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        ),
                        backgroundColor: MaterialStatePropertyAll(
                          firstCollegeSelected
                              ? secondCollegeSelected
                                  ? tAccentColor
                                  : Colors.grey
                              : Colors.grey,
                        ),
                        foregroundColor: MaterialStatePropertyAll(
                          firstCollegeSelected
                              ? secondCollegeSelected
                                  ? Colors.white
                                  : Colors.black
                              : Colors.black,
                        ),
                        elevation: const MaterialStatePropertyAll(3),
                        textStyle: MaterialStatePropertyAll(
                          TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            color: firstCollegeSelected
                                ? secondCollegeSelected
                                    ? Colors.white
                                    : Colors.black
                                : Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        side: const MaterialStatePropertyAll(
                          BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                        ),
                      ),
                      child: const Text("Compare Colleges"),
                    ),
                  ),
                )
              ],
            ),
            Visibility(
              visible: isLoading,
              child: Container(
                color: Colors.black
                    .withOpacity(0.5), // Adjust the opacity as needed
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
      ),
    );
  }
}

getColleges(String counselling) async {
  final supabase = Supabase.instance.client;
  final response = await supabase
      .from('college_details')
      .select('short_name, main_image, id')
      .eq('counselling', counselling);

  final List<dynamic>? data = response is List ? response : response['data'];

  if (data == null || data.isEmpty) {
    // Return an empty list if there is no data
    return [];
  }

  final List<collegeCompare> collegeNames = data.map<collegeCompare>((row) {
    return collegeCompare(
        collegeName: row['short_name'].toString(),
        collegeImage: row['main_image'].toString(),
        collegeId: row['id']);
  }).toList();

  return collegeNames;
}

Future bottomSheetToShowColleges(BuildContext context, isDark,
    List<collegeCompare> data, String selectedCollege, onPressed) {
  // Remove selectedCollege from the data list
  data.removeWhere((college) => college.collegeName == selectedCollege);

  return showModalBottomSheet(
    enableDrag: true,
    isDismissible: true,
    context: context,
    showDragHandle: true,
    useSafeArea: true,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(8.0),
          itemCount: data.length,
          itemBuilder: (context, i) {
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    onPressed(data[i].collegeName, data[i].collegeImage,
                        data[i].collegeId);
                    Navigator.pop(context);
                  },
                  child: Text(
                    data[i].collegeName,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Divider(
                  height: 20,
                  thickness: 2,
                  indent: 20,
                  endIndent: 20,
                  color: Colors.grey,
                ),
              ],
            );
          },
        ),
      );
    },
  );
}

class collegeCompare {
  int collegeId;
  String collegeName;
  String collegeImage;
  collegeCompare({
    required this.collegeId,
    required this.collegeName,
    required this.collegeImage,
  });
}

getCollegesData(int collegeId) async {
  try {
    final data = await getCollegeDetailsList(collegeId);
    return data;
  } catch (e) {
    debugPrint("Error occuring during getting comparison parameters $e");
  }
}
