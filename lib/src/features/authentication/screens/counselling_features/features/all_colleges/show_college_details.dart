import 'package:collegemitra/src/features/authentication/models/all_colleges_model.dart';
import 'package:collegemitra/src/features/authentication/screens/counselling_features/features/all_colleges/widgets/about.dart';
import 'package:collegemitra/src/features/authentication/screens/counselling_features/features/all_colleges/widgets/branches.dart';
import 'package:collegemitra/src/features/authentication/screens/counselling_features/features/all_colleges/widgets/cutoff.dart';
import 'package:collegemitra/src/features/authentication/screens/counselling_features/features/all_colleges/widgets/media_tab.dart';
import 'package:collegemitra/src/features/authentication/screens/counselling_features/features/all_colleges/widgets/placement_tab.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: collegeDetails.isEmpty
            ? const Text('Loading...')
            : Text(
                collegeDetails[0].collegeShortName,
                style: const TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
        centerTitle: true,
        elevation: 2,
        bottom: TabBar(
          labelColor: Colors.deepOrange,
          indicatorColor: Colors.deepOrange,
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
                CutoffPage(collegeName: collegeDetails[0].collegeFullName),
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
