import 'package:collegemitra/src/features/authentication/screens/counselling_features/features/all_colleges/widgets/about.dart';
import 'package:collegemitra/src/features/authentication/screens/counselling_features/features/all_colleges/widgets/cutoff.dart';
import 'package:collegemitra/src/features/authentication/screens/counselling_features/features/all_colleges/widgets/media_tab.dart';
import 'package:collegemitra/src/features/authentication/screens/counselling_features/features/all_colleges/widgets/placement_tab.dart';
import 'package:flutter/material.dart';

class ShowCollegeDetails extends StatefulWidget {
  const ShowCollegeDetails({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ShowCollegeDetailsState createState() => _ShowCollegeDetailsState();
}

class _ShowCollegeDetailsState extends State<ShowCollegeDetails>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this); // 6 tabs
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'NIT Warangal',
          style: TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
            shadows: <Shadow>[
              Shadow(
                offset: Offset(0.5, 1.0),
                blurRadius: 2.0,
                color: Colors.black,
              ),
            ],
          ),
        ),
        centerTitle: true,
        bottom: TabBar(
          labelColor: Colors.deepOrange,
          indicatorColor: Colors.deepOrange,
          isScrollable: true,
          controller: _tabController,
          tabs: const [
            Tab(text: 'About'),
            Tab(text: 'Cutoffs'),
            Tab(text: 'Placement Records'),
            Tab(text: 'Media'),
            Tab(text: 'Admission'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Replace these with your corresponding widgets for each tab
          AboutPage(),
          const CutoffPage(),
          const PlacementsTab(),
          const MediaMain(),
          const Center(child: Text('Admission Page')),
        ],
      ),
    );
  }
}
