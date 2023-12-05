// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:collegemitra/src/constants/colors.dart';
import 'package:collegemitra/src/features/authentication/screens/general_utils/carousel_slider.dart';
import 'package:collegemitra/src/repository/authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../features/authentication/screens/counselling_features/features/rank_predictor/rank_predictor.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final auth = AuthenticationRepository.instance;
  int _currentIndex = 0;
  List<String> counselling = [
    "Select the counselling",
    "JOSAA",
    "CSAB",
    "HSTES",
    "UPTU",
    "MPDTE",
    "UTU",
    "GGSIPU Delhi",
    "JAC Delhi"
  ];

  final List<Widget> _pages = [
    const DashboardScreen(),
    // Add content for the second page here
    const CounsellingInformation(),
    // Add content for the third page here
    const Text('Premium Page Content'),
    // Add content for the fourth page here
    const Text('Profile Page Content'),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 2,
        title: const Text("Admin Panel"),
        actions: [
          IconButton(
            onPressed: () {
              auth.logout();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blueAccent.shade100.withOpacity(0.1),
        elevation: 1,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blueAccent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.newspaper_rounded), label: "Blogs"),
          BottomNavigationBarItem(
              icon: Icon(Icons.card_membership), label: "Premium"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String selectedSection = "Select the section";

  @override
  Widget build(BuildContext context) {
    List<String> section = ["Select the section", "HEADER", "FOOTER"];
    return Scaffold(
      body: SingleChildScrollView(
        child: ListView(
          padding: const EdgeInsets.all(14.0),
          children: [
            const SizedBox(height: 10),
            const MyCarouselSlider(),
            const SizedBox(height: 10),
            Text(
              "Header & Footer Video",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              "Select Section and start CRUD Operation...",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 10),
            detailsDropdown(
              "Select the Section",
              section,
              MediaQuery.of(context).size.width,
              (value) {
                setState(() {
                  selectedSection = value;
                });
              },
              "Select Section",
              "Please Select the section that you want to explore",
              context,
            ),
            showDataTableForHeaderAndFooter(selectedSection),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Access the controller and update data
          setState(() {});
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

Widget showDataTableForHeaderAndFooter(String section) {
  print("Called the showData Table");
  final supabase = Supabase.instance.client;

  // Fetch data from Supabase based on the selected counselling
  const tableName = 'header_footer_video';
  const sectionColumn = 'position';

  return Builder(builder: (BuildContext builderContext) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      ElevatedButton(
        onPressed: () {
          // Implement your logic to add new data
          // This could include navigating to a new screen or showing a form
          // where the user can input new data.
          // For simplicity, I'm just printing a message here.
          print('Add New Button Pressed');
          addContentModalBottomSheetHeaderAndFooter(section, builderContext);
        },
        child: const Text('Add New'),
      ),
      const SizedBox(height: 16),
      FutureBuilder(
        // Fetch data using Supabase query
        future: supabase.from(tableName).select().eq(sectionColumn, section),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Text('No data available.');
          } else {
            // Extract data from snapshot
            final dynamic responseData = snapshot.data!;

            // Check if the response is a list with a 'data' property
            final List<dynamic>? data =
                responseData is List ? responseData : responseData['data'];

            if (data == null || data.isEmpty) {
              return const Text('No data available.');
            }

            // Define DataTable columns
            final columns = [
              const DataColumn(label: Text('ID')),
              const DataColumn(label: Text('Video Link')),
              const DataColumn(label: Text('Actions')),
            ];

            // Define DataTable rows
            final rows = data.map<DataRow>((row) {
              return DataRow(
                cells: [
                  DataCell(Text('${row['id']}')),
                  DataCell(Text('${row['video_link']}')),
                  DataCell(Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          editContentModalBottomSheetHeaderAndFooter(
                              row['id'], row['video_link'], builderContext);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          bool confirmDelete =
                              await showDeleteConfirmationDialog(context);
                          if (confirmDelete) {
                            // Delete the content from Supabase
                            final response = await supabase
                                .from(tableName)
                                .delete()
                                .match({'id': row['id']});

                            // Content deleted successfully
                            showConfirmationDialog(context, 'Content Deleted');
                          }
                          // Implement delete action
                        },
                      ),
                    ],
                  )),
                ],
              );
            }).toList();

            // Wrap the DataTable with SingleChildScrollView and Scrollbar
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Scrollbar(
                child: DataTable(columns: columns, rows: rows),
              ),
            );
          }
        },
      )
    ]);
  });
}

Future<void> editContentModalBottomSheetHeaderAndFooter(
    int id, String link, BuildContext context) async {
  final supabase = Supabase.instance.client;
  TextEditingController linkController = TextEditingController(text: link);

  try {
    await showModalBottomSheet(
      showDragHandle: true,
      useSafeArea: true,
      isScrollControlled: true, // Full height modal
      context: context,
      builder: (context) => SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Edit Video Link',
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: linkController,
                      decoration:
                          const InputDecoration(labelText: 'Video Link'),
                    ),
                    const SizedBox(height: 16),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        // Update the content in Supabase
                        final response =
                            await supabase.from('header_footer_video').update({
                          'video_link': linkController.text,
                        }).match({'id': id});

                        // Content updated successfully
                        Navigator.pop(context); // Close the bottom sheet
                        showConfirmationDialog(context, 'Link Updated');
                      },
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  } catch (error) {
    // Handle other errors
    print('Error: $error');
  }
}

Future addContentModalBottomSheetHeaderAndFooter(
    String section, BuildContext context) {
  final supabase = Supabase.instance.client;
  TextEditingController linkController = TextEditingController(text: "");

  return showModalBottomSheet(
    isScrollControlled: true,
    showDragHandle: true,
    useSafeArea: true,
    context: context,
    builder: (context) => SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Add Video Link',
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: linkController,
                    decoration: const InputDecoration(labelText: 'Video Link'),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () async {
                      // Update the content in Supabase
                      final response = await supabase
                          .from('header_footer_video')
                          .insert({
                        'video_link': linkController.text.trim(),
                        'position': section
                      });

                      // Content updated successfully

                      Navigator.pop(context); // Close the bottom sheet
                      showConfirmationDialog(context, 'Content Added');
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

//Counselling information content
class CounsellingInformation extends StatefulWidget {
  const CounsellingInformation({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CounsellingInformationState createState() => _CounsellingInformationState();
}

class _CounsellingInformationState extends State<CounsellingInformation> {
  String selectedCounselling = "Select the counselling";

  @override
  Widget build(BuildContext context) {
    List<String> counselling = [
      "Select the counselling",
      "JOSAA",
      "CSAB",
      "HSTES",
      "UPTU",
      "MPDTE",
      "UTU",
      "GGSIPU Delhi",
      "JAC Delhi"
    ];
    return Scaffold(
      body: SingleChildScrollView(
        child: ListView(
          padding: const EdgeInsets.all(14.0),
          children: [
            const SizedBox(height: 10),
            Text(
              "Counselling Content",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              "Select Counselling and start CRUD Operation...",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 15),
            detailsDropdown(
              "Select the Counselling",
              counselling,
              MediaQuery.of(context).size.width,
              (value) {
                setState(() {
                  selectedCounselling = value;
                });
              },
              "Select Counselling",
              "Please Select the counselling that you want to explore",
              context,
            ),
            showDataTable(selectedCounselling),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Access the controller and update data
          setState(() {});
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

Widget showDataTable(String counselling) {
  print("Called the showData Table");
  final supabase = Supabase.instance.client;

  // Fetch data from Supabase based on the selected counselling
  const tableName = 'counselling_information';
  const counsellingColumn = 'counselling';

  return Builder(builder: (BuildContext builderContext) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      ElevatedButton(
        onPressed: () {
          // Implement your logic to add new data
          // This could include navigating to a new screen or showing a form
          // where the user can input new data.
          // For simplicity, I'm just printing a message here.
          print('Add New Button Pressed');
          addContentModalBottomSheet(counselling, builderContext);
        },
        child: const Text('Add New'),
      ),
      const SizedBox(height: 16),
      FutureBuilder(
        // Fetch data using Supabase query
        future: supabase
            .from(tableName)
            .select()
            .eq(counsellingColumn, counselling),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Text('No data available.');
          } else {
            // Extract data from snapshot
            final dynamic responseData = snapshot.data!;

            // Check if the response is a list with a 'data' property
            final List<dynamic>? data =
                responseData is List ? responseData : responseData['data'];

            if (data == null || data.isEmpty) {
              return const Text('No data available.');
            }

            // Define DataTable columns
            final columns = [
              const DataColumn(label: Text('ID')),
              const DataColumn(label: Text('Title')),
              const DataColumn(label: Text('Description')),
              const DataColumn(label: Text('Actions')),
            ];

            // Define DataTable rows
            final rows = data.map<DataRow>((row) {
              return DataRow(
                cells: [
                  DataCell(Text('${row['id']}')),
                  DataCell(Text('${row['title']}')),
                  DataCell(
                    SizedBox(
                      width: 200, // Adjust the width based on your preference
                      child: Text(
                        '${row['description']}...',
                        maxLines: 2,

                        // Set the maximum number of lines
                        overflow: TextOverflow
                            .ellipsis, // Show ellipsis if text overflows
                      ),
                    ),
                  ),
                  DataCell(Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          // Implement edit action
                          editContentModalBottomSheet(row['id'], row['title'],
                              row['description'], counselling, builderContext);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          bool confirmDelete =
                              await showDeleteConfirmationDialog(context);
                          if (confirmDelete) {
                            // Delete the content from Supabase
                            final response = await supabase
                                .from('counselling_information')
                                .delete()
                                .match({'id': row['id']});

                            // Content deleted successfully
                            showConfirmationDialog(context, 'Content Deleted');
                          }
                          // Implement delete action
                        },
                      ),
                    ],
                  )),
                ],
              );
            }).toList();

            // Wrap the DataTable with SingleChildScrollView and Scrollbar
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Scrollbar(
                child: DataTable(columns: columns, rows: rows),
              ),
            );
          }
        },
      )
    ]);
  });
}

Widget detailsDropdown(
    String hint,
    List<String> list,
    double mobileWidth,
    Function(String) onChanged,
    String title,
    String description,
    BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 2),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: mobileWidth - 85,
          child: CustomDropdown<String>(
            closedFillColor: Colors.transparent,
            closedBorder:
                Border.all(color: const Color.fromARGB(255, 138, 136, 136)),
            hintText: hint,
            items: list,
            initialItem: list[0],
            onChanged: (value) {
              onChanged(value);

              log('changing value to: $value');
            },
          ),
        ),
        GestureDetector(
          child: const Icon(
            Icons.info_rounded,
            size: 30,
            color: tAccentColor,
          ),
          onTap: () {
            // showDialog(
            //   context: context,
            //   builder: (BuildContext context) {
            //     return const AlertDialog(
            //       title: Text("What"),
            //     );
            //   },
            // );
            showInformation(context, title, description);
          },
        ),
      ],
    ),
  );
}

Future<void> editContentModalBottomSheet(int id, String title,
    String description, String counselling, BuildContext context) async {
  final supabase = Supabase.instance.client;
  TextEditingController titleController = TextEditingController(text: title);
  TextEditingController descriptionController =
      TextEditingController(text: description);

  try {
    await showModalBottomSheet(
      showDragHandle: true,
      useSafeArea: true,
      isScrollControlled: true, // Full height modal
      context: context,
      builder: (context) => SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Edit Content',
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: titleController,
                      decoration: const InputDecoration(labelText: 'Title'),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: descriptionController,
                      decoration:
                          const InputDecoration(labelText: 'Description'),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        // Update the content in Supabase
                        final response = await supabase
                            .from('counselling_information')
                            .update({
                          'title': titleController.text,
                          'description': descriptionController.text,
                        }).match({'id': id});

                        // Content updated successfully
                        Navigator.pop(context); // Close the bottom sheet
                        showConfirmationDialog(context, 'Content Updated');
                      },
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  } catch (error) {
    // Handle other errors
    print('Error: $error');
  }
}

// Helper function to show a confirmation dialog
void showConfirmationDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Success'),
        content: Text(message),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Close the dialog
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

Future<bool> showDeleteConfirmationDialog(BuildContext context) async {
  return await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Delete Confirmation'),
            content:
                const Text('Are you sure you want to delete this content?'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, true); // Return true if confirmed
                },
                child: const Text('Yes'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, false); // Return false if canceled
                },
                child: const Text('No'),
              ),
            ],
          );
        },
      ) ??
      false;
}

Future addContentModalBottomSheet(String counselling, BuildContext context) {
  final supabase = Supabase.instance.client;
  TextEditingController titleController = TextEditingController(text: "");
  TextEditingController descriptionController = TextEditingController(text: "");

  return showModalBottomSheet(
    isScrollControlled: true,
    showDragHandle: true,
    useSafeArea: true,
    context: context,
    builder: (context) => SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Add Content',
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(labelText: 'Title'),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: descriptionController,
                    decoration: const InputDecoration(labelText: 'Description'),
                    maxLines: 4,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () async {
                      // Update the content in Supabase
                      final response = await supabase
                          .from('counselling_information')
                          .insert({
                        'title': titleController.text.trim(),
                        'description': descriptionController.text.trim(),
                        'counselling': counselling
                      });

                      // Content updated successfully

                      Navigator.pop(context); // Close the bottom sheet
                      showConfirmationDialog(context, 'Content Added');
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
