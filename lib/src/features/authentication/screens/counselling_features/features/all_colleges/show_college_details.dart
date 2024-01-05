import 'package:collegemitra/src/constants/colors.dart';
import 'package:collegemitra/src/features/authentication/models/all_colleges_model.dart';
import 'package:collegemitra/src/features/authentication/screens/counselling_features/features/all_colleges/widgets/about.dart';
import 'package:collegemitra/src/features/authentication/screens/counselling_features/features/all_colleges/widgets/branches.dart';
import 'package:collegemitra/src/features/authentication/screens/counselling_features/features/all_colleges/widgets/cutoff.dart';
import 'package:collegemitra/src/features/authentication/screens/counselling_features/features/all_colleges/widgets/media_tab.dart';
import 'package:collegemitra/src/features/authentication/screens/counselling_features/features/all_colleges/widgets/placement_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowCollegeDetails extends StatefulWidget {
  final int collegeId;
  const ShowCollegeDetails({super.key, required this.collegeId});

  @override
  _ShowCollegeDetailsState createState() => _ShowCollegeDetailsState();
}

class _ShowCollegeDetailsState extends State<ShowCollegeDetails>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<CollegeDetails> collegeDetails = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this); // 6 tabs
    _getData();
  }

  void _getData() async {
    await Future.delayed(const Duration(microseconds: 500));
    collegeDetails = await getCollegeDetailsList(widget.collegeId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark
          ? const Color.fromARGB(255, 19, 19, 19)
          : const Color(0xFFF1F4F8),
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
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
        title: collegeDetails.isEmpty
            ? const Text('Loading...')
            : Text(
                collegeDetails[0].collegeShortName,
                style: TextStyle(
                  color: isDark ? tPrimaryColor.shade200 : tPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
        centerTitle: true,
        elevation: 2,
        bottom: TabBar(
          labelColor: tAccentColor,
          indicatorColor: tAccentColor,
          isScrollable: true,
          controller: _tabController,
          tabs: const [
            Tab(text: 'About'),
            Tab(text: 'Cutoffs'),
            Tab(text: 'Fees'),
            Tab(text: 'Placement Records'),
            Tab(text: 'Media'),
            Tab(text: 'Admission'),
          ],
        ),
      ),
      body: collegeDetails.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                // Replace these with your corresponding widgets for each tab
                AboutPage(collegeDetails: collegeDetails),
                CutoffPage(
                  collegeName: collegeDetails[0].collegeFullName,
                  collegeType: collegeDetails[0].collegeType,
                ),
                Branchestab(collegeDetails: collegeDetails),
                PlacementsTab(
                  collegeDetails: collegeDetails,
                ),
                MediaMain(collegedetails: collegeDetails),
                const Center(child: Text('Admission Page')),
              ],
            ),
    );
  }
}
