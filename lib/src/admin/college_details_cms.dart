import 'dart:convert';

import 'package:collegemitra/src/admin/college_details_controller.dart';
import 'package:collegemitra/src/admin/widgets/branchwise_placements.dart';
import 'package:collegemitra/src/features/authentication/screens/general_utils/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CollegeDetailsCMS extends StatefulWidget {
  const CollegeDetailsCMS({super.key});

  @override
  State<CollegeDetailsCMS> createState() => _CollegeDetailsCMSState();
}

class _CollegeDetailsCMSState extends State<CollegeDetailsCMS> {
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;

  final controller = Get.put(CollegeDetailsCMSController());

  String selectedCounselling = "Select the Counselling";
  String selectedCollege = "Select the college";
  String selectedBranch = "Select the branch";
  String branchDetailsJson = "";

  List<String> colleges = [];

  List<String> branches = [];
  Map<String, bool> facilityValues = {
    'auditorium': true,
    'library': true,
    'fest': true,
    'sports_complex': true,
    'wifi': true,
    'hostels': true,
    'atm': true,
    'lab': true,
    'clubs': true,
    'gym': true,
    'canteen': true,
    'medical_support': true,
    // Add more facilities as needed
  };

  // Map to store company names and their corresponding image links
  Map<String, String> branchPlacementPercentage = {};

  @override
  Widget build(BuildContext context) {
    String commonFee = controller.fees.text;

    List<String> counselling = [
      "Select the Counselling",
      "JOSAA",
      "JAC Delhi",
      "GGSIPU Delhi",
      "UPTU",
      "HSTES",
      "MPDTE",
    ];

    return Scaffold(
      body: Stack(
        children: [
          ListView.builder(
            controller: _scrollController,
            itemCount: 1,
            padding: const EdgeInsets.all(12),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Text(
                    "College Details",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    "Select Counselling and start CRUD Operation...",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const Divider(color: Colors.blue, thickness: 4, height: 15),
                  const SizedBox(height: 20),
                  detailsDropdown("Select the Counselling", counselling,
                      MediaQuery.of(context).size.width, (value) async {
                    setState(() {
                      selectedCounselling = value;
                      isLoading = true;
                    });
                    List<String> data = await getCollegesList(value);
                    setState(() {
                      colleges = data;
                      isLoading = false;
                    });
                  },
                      "Please select the counselling",
                      "Please select the counselling to get colleges for editing or adding info.",
                      context),

                  colleges.isEmpty
                      ? const SizedBox(height: 0)
                      : detailsDropdown("Select the college", colleges,
                          MediaQuery.of(context).size.width, (value) async {
                          setState(() {
                            isLoading = true;
                            selectedCollege = value;
                          });
                          await controller.populateCollegeDetailsFromSupabase(
                              selectedCollege, (jsonData) {
                            Map<String, dynamic> placementData =
                                jsonDecode(jsonData);
                            branchPlacementPercentage = placementData.map(
                              (branch, percentage) =>
                                  MapEntry(branch, percentage.toString()),
                            );
                          });

                          setState(() {
                            isLoading = false;
                          });
                        },
                          "Please select the college",
                          "Select the college to add or edit the details about college",
                          context),

                  const SizedBox(height: 10),

                  Text(
                    selectedCollege,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),

                  const SizedBox(height: 10),
                  TextFormField(
                    controller: controller.shortName,
                    decoration: const InputDecoration(
                        labelText: "College Short Name (IIT Mandi)"),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: controller.state,
                    decoration: const InputDecoration(labelText: "State"),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: controller.address,
                    decoration: const InputDecoration(
                        labelText: "College Complete Address"),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: controller.nearbyAirport,
                    decoration: const InputDecoration(
                        labelText: "Nearby Airport Name - Distance(In KM)"),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: controller.nearbyRailway,
                    decoration: const InputDecoration(
                        labelText: "Nearby Railway Name - Distance(In KM)"),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: controller.nearbyBus,
                    decoration: const InputDecoration(
                        labelText: "Nearby Bus Stand Name - Distance(In KM)"),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: controller.accreditation,
                    decoration: const InputDecoration(
                        labelText:
                            "Accreditation (NAAC Grade) - Not For IIT, NIT & IIIT"),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: controller.type,
                    decoration: const InputDecoration(
                        labelText: "College Type - NIT or IIT or Govt."),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: controller.establishedIn,
                    decoration:
                        const InputDecoration(labelText: "Founded In - 1987"),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: controller.description,
                    decoration: const InputDecoration(
                        labelText: "Small 3 line Description"),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: controller.campusArea,
                    decoration: const InputDecoration(
                        labelText: "Campus Area(In KM^2)"),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: controller.averagePackage,
                    decoration: const InputDecoration(
                        labelText: "Average Package(In LPA) - 6.4 LPA"),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: controller.highestPackage,
                    decoration: const InputDecoration(
                        labelText: "Highest Package(In LPA) - 56.4 LPA"),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: controller.mainImage,
                    decoration: const InputDecoration(
                        labelText:
                            "College Main Image Link - .jpg, .png, .jpeg"),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: controller.images,
                    decoration: const InputDecoration(
                        labelText:
                            "College Images Link seperated by comma, atleast 7 - - .jpg, .png, .jpeg"),
                    maxLines: 4,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: controller.videoLinks,
                    decoration: const InputDecoration(
                        labelText:
                            "1 or 2 Youtube Video Link seperated by comma"),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: controller.ranking,
                    decoration: const InputDecoration(
                        labelText: "College Ranking with Rank name"),
                    maxLines: 1,
                  ),
                  const SizedBox(height: 10),

                  TextFormField(
                    controller: controller.fees,
                    decoration: const InputDecoration(
                        labelText: "College Fees - ₹56,000 Yearly"),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: controller.boysHostelFee,
                    decoration: const InputDecoration(
                        labelText: "Boys Hostel Fees - ₹10,000"),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: controller.girlsHostelFee,
                    decoration: const InputDecoration(
                        labelText: "Girls Hostel Fees - ₹10,000"),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: controller.phone,
                    decoration:
                        const InputDecoration(labelText: "College Phone No."),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: controller.email,
                    decoration:
                        const InputDecoration(labelText: "College Email"),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: controller.website,
                    decoration:
                        const InputDecoration(labelText: "College Website"),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "College Facilities",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Divider(color: Colors.blue, thickness: 4, height: 15),
                  const SizedBox(height: 20),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: facilityValues.keys.map((facility) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(facility),
                          Switch(
                            value: facilityValues[facility] ?? true,
                            onChanged: (bool value) {
                              setState(() {
                                facilityValues[facility] = value;
                              });
                            },
                          ),
                        ],
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 15),
                  Text(
                    "College Placements",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),

                  const Divider(color: Colors.blue, thickness: 4, height: 15),
                  const SizedBox(height: 20),
                  Text(
                    "First Enter Branch wise placement Percentage",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.green),
                        elevation: MaterialStatePropertyAll(3),
                      ),
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        List<String> data = await getBranchesList(
                            selectedCollege, selectedCounselling);

                        await saveBranchDetails(data);
                        setState(() {
                          branches = data;
                          isLoading = false;
                        });
                      },
                      icon: isLoading
                          ? const CircularProgressIndicator()
                          : const Icon(Icons.percent),
                      label: isLoading
                          ? const Text("Loading...")
                          : const Text("Enter Branchwise Placements"),
                    ),
                  ),

                  const SizedBox(height: 20),

                  branchPlacementPercentage.isEmpty
                      ? const SizedBox(height: 0)
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children:
                              branchPlacementPercentage.keys.map((branch) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(branch),
                                  ),
                                  const SizedBox(width: 16.0),
                                  Expanded(
                                    flex: 2,
                                    child: TextFormField(
                                      initialValue:
                                          branchPlacementPercentage[branch],
                                      onChanged: (value) {
                                        setState(() {
                                          branchPlacementPercentage[branch] =
                                              value;
                                        });
                                      },
                                      decoration: const InputDecoration(
                                          labelText: "Placement %age"),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),

                  const SizedBox(height: 15),
                  Text(
                    "Write the company names by seperating them with comma and then click Green coloured save Button...",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: controller.companyImagesController,
                    decoration: const InputDecoration(
                        labelText:
                            "Company Images that Come(Seperated by Comma)"),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 20),
                  // Button to save company details

                  TextFormField(
                    controller: controller.uploadedBy,
                    decoration:
                        const InputDecoration(labelText: "Enter Your Name..."),
                  ),

                  const SizedBox(height: 35),
                  Text(
                    "Click the final submit button only when you have entered all the details correctly...",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 20),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          await controller.storeCollegeDetailsToSupabase(
                              selectedCollege,
                              selectedCounselling,
                              controller.companyImagesController.text.trim(),
                              branchesToJson(branches, commonFee),
                              facilitiesToJson(facilityValues),
                              companiesToJson(branchPlacementPercentage));

                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Success"),
                                  content: Text(
                                      "$selectedCollege data has been received!"),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: (() =>
                                            Navigator.pop(context)),
                                        child: const Text("Okay"))
                                  ],
                                );
                              });

                          setState(() {
                            isLoading = false;
                          });
                        },
                        child: isLoading
                            ? const CircularProgressIndicator()
                            : const Text("Save Data to Database")),
                  ),
                  const SizedBox(height: 100),
                ],
              );
            },
          ),
          Visibility(
            visible: isLoading,
            child: Container(
              color:
                  Colors.black.withOpacity(0.5), // Adjust the opacity as needed
              child: Center(
                child: Image.asset(
                  "assets/gif/loader.gif",
                  width: MediaQuery.of(context).size.width / 4,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.updateCollegeDetailsToSupabase(
              selectedCollege,
              selectedCounselling,
              controller.companyImagesController.text.trim(),
              branchesToJson(branches, commonFee),
              facilitiesToJson(facilityValues),
              companiesToJson(branchPlacementPercentage));

          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Success"),
                  content: Text("$selectedCollege data has been updated!"),
                  actions: [
                    ElevatedButton(
                        onPressed: (() => Navigator.pop(context)),
                        child: const Text("Okay"))
                  ],
                );
              });

          // Scroll to the previous position
          setState(() {});
        },
        child: Container(
          width: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(8),
          child: const Text("Update"),
        ),
      ),
    );
  }

  saveBranchDetails(branches) {
    // Example: Set default image link for each company
    String placementPercentage = '60%';

    // Store company details in the map
    for (String branch in branches) {
      branchPlacementPercentage[branch] = placementPercentage;
    }
  }
}
