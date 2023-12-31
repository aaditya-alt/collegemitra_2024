import 'dart:io';
import 'package:collegemitra/src/admin/college_details_cms.dart';
import 'package:collegemitra/src/features/authentication/screens/general_utils/carousel_slider.dart';
import 'package:collegemitra/src/features/authentication/screens/general_utils/dropdown.dart';
import 'package:collegemitra/src/repository/authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final auth = AuthenticationRepository.instance;
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const DashboardScreen(),
    // Add content for the second page here
    const CounsellingInformation(),
    // Add content for the third page here
    const CollegeDetailsCMS(),
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
  String selectedCounsellingForBlogs = "Select the Counselling";
  String selectedCounsellingForTestimonials = "Select the Counselling";
  String selectedCounsellingForPromotionalImage = "Select the Counselling";

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> section = ["Select the section", "HEADER", "FOOTER"];
    List<String> counselling = [
      "Select the counselling",
      "POPULAR",
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
      body: ListView(
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
          const SizedBox(height: 15),

          //Blogs card section
          const Divider(
            thickness: 4,
            color: Colors.blue,
            height: 15,
          ),
          const SizedBox(height: 25),
          Text(
            "Blogs Section",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            "Select Counselling and start CRUD Operation...",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 10),
          detailsDropdown(
            "Select the Counselling",
            counselling,
            MediaQuery.of(context).size.width,
            (value) {
              setState(() {
                selectedCounsellingForBlogs = value;
              });
            },
            "Select Counselling",
            "Please Select the counselling for blogs Card that you want to explore",
            context,
          ),
          showDataTableForBlogsCard(selectedCounsellingForBlogs),
          const SizedBox(height: 15),

          //Testimonial section

          const Divider(
            thickness: 4,
            color: Colors.blue,
            height: 15,
          ),
          const SizedBox(height: 25),
          Text(
            "Testimonials Section",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            "Select Counselling and start CRUD Operation...",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 10),
          detailsDropdown(
            "Select the Counselling",
            counselling,
            MediaQuery.of(context).size.width,
            (value) {
              setState(() {
                selectedCounsellingForTestimonials = value;
              });
            },
            "Select Counselling",
            "Please Select the counselling for Testimonials that you want to explore",
            context,
          ),
          showDataTableForTestimonials(selectedCounsellingForTestimonials),

          const SizedBox(height: 15),

          //Testimonial section

          const Divider(
            thickness: 4,
            color: Colors.blue,
            height: 15,
          ),
          const SizedBox(height: 25),
          Text(
            "Promotional Image",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            "Select Counselling and start CRUD Operation...",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 10),
          detailsDropdown(
            "Select the Counselling",
            counselling,
            MediaQuery.of(context).size.width,
            (value) {
              setState(() {
                selectedCounsellingForPromotionalImage = value;
              });
            },
            "Select Counselling",
            "Please Select the counselling for promotional Image that you want to explore",
            context,
          ),
          showDataTableForPromotionalImage(
              selectedCounsellingForPromotionalImage),

          const SizedBox(height: 100),
        ],
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

//Show data for promotional Image
Widget showDataTableForPromotionalImage(String counselling) {
  print("Called the showData Table");
  final supabase = Supabase.instance.client;

  // Fetch data from Supabase based on the selected counselling
  const tableName = 'promotional_image';
  const counsellingColumn = 'counselling';

  return Builder(builder: (BuildContext builderContext) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      const SizedBox(height: 16),
      FutureBuilder(
        // Fetch data using Supabase query
        future: supabase
            .from(tableName)
            .select()
            .eq(counsellingColumn, counselling),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
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
              const DataColumn(label: Text('Image Link')),
              const DataColumn(label: Text('Image')),
              const DataColumn(label: Text('Actions')),
            ];

            // Define DataTable rows
            final rows = data.map<DataRow>((row) {
              return DataRow(
                cells: [
                  DataCell(Text('${row['id']}')),
                  DataCell(Text('${row['image_link']}')),
                  DataCell(Image.network(
                    "${row['image_link']}",
                    width: MediaQuery.of(context).size.width / 2,
                  )),
                  DataCell(Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          editContentModalBottomSheetForPromotionalImage(
                              row['id'], row['image_link'], builderContext);
                          // editContentModalBottomSheetForTestimonials(
                          //     row['id'],
                          //     row['name'],
                          //     row['designation'],
                          //     row['image_link'],
                          //     row['comment'],
                          //     builderContext);
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
                            showConfirmationDialog(
                                builderContext, 'Content Deleted');
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

//Edit data for promotional Image
Future<void> editContentModalBottomSheetForPromotionalImage(
    int id, String imageLink, BuildContext context) async {
  final supabase = Supabase.instance.client;

  TextEditingController imageLinkController =
      TextEditingController(text: imageLink);

  File? pickedImage; // Add a variable to store the picked image file

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Set the picked image file path to the image controller
      imageLinkController.text = pickedFile.path;
      pickedImage = File(pickedFile.path); // Store the picked image file
    }
  }

  Future<void> uploadImageAndHandleUpdate(
      int id, String imagePath, BuildContext context) async {
    final file = File(imagePath);
    final random = const Uuid().v1();
    String defaultHalfPath =
        "https://kclsmsgznxxrnboeopjw.supabase.co/storage/v1/object/public";
    final response = await supabase.storage
        .from('testimonials_images')
        .upload('public/$random.jpg', file); // Use a unique filename

    // Update the content in Supabase with the new image link
    String fullImageLink =
        "$defaultHalfPath/testimonials_images/public/$random.jpg";
    final updateResponse = await supabase.from('promotional_image').update({
      'image_link': fullImageLink,
      // Use the key from the storage response
    }).match({'id': id});
  }

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
                      'Edit Promotional Image',
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: pickedImage != null
                                ? Image.file(
                                    pickedImage!,
                                    height: 100,
                                  )
                                : Image.network(
                                    imageLinkController.text.trim(),
                                    height: 100,
                                  )),
                        IconButton(
                          icon: const Icon(Icons.image),
                          onPressed: _pickImage,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        uploadImageAndHandleUpdate(
                            id, imageLinkController.text.trim(), context);

                        // Content updated successfully
                        Navigator.pop(context); // Close the bottom sheet
                        showConfirmationDialog(
                            context, 'Promotional Image Updated');
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

//Show data for testimonials section
Widget showDataTableForTestimonials(String counselling) {
  print("Called the showData Table");
  final supabase = Supabase.instance.client;

  // Fetch data from Supabase based on the selected counselling
  const tableName = 'testimonials';
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
          addContentModalBottomSheetForTestimonials(
              counselling, builderContext);
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
            return const Center(child: CircularProgressIndicator());
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
              const DataColumn(label: Text('Name')),
              const DataColumn(label: Text('Designation')),
              const DataColumn(label: Text('Image')),
              const DataColumn(label: Text('Comment')),
              const DataColumn(label: Text('Actions')),
            ];

            // Define DataTable rows
            final rows = data.map<DataRow>((row) {
              return DataRow(
                cells: [
                  DataCell(Text('${row['id']}')),
                  DataCell(Text('${row['name']}')),
                  DataCell(Text('${row['designation']}')),
                  DataCell(Image.network(
                    "${row['image_link']}",
                    width: MediaQuery.of(context).size.width / 2,
                  )),
                  DataCell(Text('${row['comment']}')),
                  DataCell(Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          editContentModalBottomSheetForTestimonials(
                              row['id'],
                              row['name'],
                              row['designation'],
                              row['image_link'],
                              row['comment'],
                              builderContext);
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
                            showConfirmationDialog(
                                builderContext, 'Content Deleted');
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

//Edit testimonials section card
Future<void> editContentModalBottomSheetForTestimonials(
    int id,
    String name,
    String designation,
    String imageLink,
    String comment,
    BuildContext context) async {
  final supabase = Supabase.instance.client;
  TextEditingController nameController = TextEditingController(text: name);
  TextEditingController designationController =
      TextEditingController(text: designation);
  TextEditingController imageLinkController =
      TextEditingController(text: imageLink);
  TextEditingController commentController =
      TextEditingController(text: comment);

  File? pickedImage; // Add a variable to store the picked image file

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Set the picked image file path to the image controller
      imageLinkController.text = pickedFile.path;
      pickedImage = File(pickedFile.path); // Store the picked image file
    }
  }

  Future<void> uploadImageAndHandleUpdate(int id, String imagePath, String name,
      String designation, String comment, BuildContext context) async {
    final file = File(imagePath);
    final random = const Uuid().v1();
    String defaultHalfPath =
        "https://kclsmsgznxxrnboeopjw.supabase.co/storage/v1/object/public";
    final response = await supabase.storage
        .from('testimonials_images')
        .upload('public/$random.jpg', file); // Use a unique filename

    // Update the content in Supabase with the new image link
    String fullImageLink =
        "$defaultHalfPath/testimonials_images/public/$random.jpg";
    final updateResponse = await supabase.from('testimonials').update({
      'name': name,
      'designation': designation,
      'image_link': fullImageLink,
      'comment': comment, // Use the key from the storage response
    }).match({'id': id});
  }

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
                      'Edit Testimonial Card',
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: pickedImage != null
                                ? Image.file(
                                    pickedImage!,
                                    height: 100,
                                  )
                                : Image.network(
                                    imageLinkController.text.trim(),
                                    height: 100,
                                  )),
                        IconButton(
                          icon: const Icon(Icons.image),
                          onPressed: _pickImage,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: designationController,
                      decoration:
                          const InputDecoration(labelText: 'Designation'),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: commentController,
                      decoration: const InputDecoration(labelText: 'Comment'),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        uploadImageAndHandleUpdate(
                            id,
                            imageLinkController.text.trim(),
                            nameController.text.trim(),
                            designationController.text.trim(),
                            commentController.text.trim(),
                            context);

                        // Content updated successfully
                        Navigator.pop(context); // Close the bottom sheet
                        showConfirmationDialog(
                            context, 'Testimonial Card Updated');
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

//Add testimonial card
Future<void> addContentModalBottomSheetForTestimonials(
    String counselling, BuildContext context) async {
  final supabase = Supabase.instance.client;
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController designationController = TextEditingController(text: "");
  TextEditingController imageLinkController = TextEditingController(text: "");
  TextEditingController commentController = TextEditingController(text: "");

  File? pickedImage; // Add a variable to store the picked image file

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Set the picked image file path to the image controller
      imageLinkController.text = pickedFile.path;
      pickedImage = File(pickedFile.path); // Store the picked image file
    }
  }

  Future<void> uploadImageAndHandleUpdate(
      String counselling,
      String imagePath,
      String name,
      String designation,
      String comment,
      BuildContext context) async {
    final file = File(imagePath);
    final random = const Uuid().v1();
    String defaultHalfPath =
        "https://kclsmsgznxxrnboeopjw.supabase.co/storage/v1/object/public";
    final response = await supabase.storage
        .from('testimonials_images')
        .upload('public/$random.jpg', file); // Use a unique filename

    // Update the content in Supabase with the new image link
    String fullImageLink =
        "$defaultHalfPath/testimonials_images/public/$random.jpg";
    final updateResponse = await supabase.from('testimonials').insert({
      'name': name,
      'designation': designation,
      'image_link': fullImageLink,
      'comment': comment,
      'counselling': counselling // Use the key from the storage response
    });
  }

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
                      'Add Testimonial Card',
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    // Display the picked image if available
                    pickedImage != null
                        ? Image.file(
                            pickedImage!,
                            height: 100, // Adjust the height as needed
                          )
                        : const SizedBox(),
                    const SizedBox(height: 16),
                    IconButton(
                      icon: const Icon(
                        Icons.image,
                        size: 35,
                      ),
                      onPressed: _pickImage,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: designationController,
                      decoration:
                          const InputDecoration(labelText: 'Designation'),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: commentController,
                      decoration: const InputDecoration(labelText: 'Comment'),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        uploadImageAndHandleUpdate(
                            counselling,
                            imageLinkController.text.trim(),
                            nameController.text.trim(),
                            designationController.text.trim(),
                            commentController.text.trim(),
                            context);

                        // Content updated successfully
                        Navigator.pop(context); // Close the bottom sheet
                        showConfirmationDialog(
                            context, 'Testimonial Card Added');
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

Widget showDataTableForBlogsCard(String counselling) {
  print("Called the showData Table");
  final supabase = Supabase.instance.client;

  // Fetch data from Supabase based on the selected counselling
  const tableName = 'blogs_card';
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
          addContentModalBottomSheetForBlogsCard(counselling, builderContext);
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
            return const Center(child: CircularProgressIndicator());
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
              const DataColumn(label: Text('SubTitle')),
              const DataColumn(label: Text('Image')),
              const DataColumn(label: Text('Actions')),
            ];

            // Define DataTable rows
            final rows = data.map<DataRow>((row) {
              return DataRow(
                cells: [
                  DataCell(Text('${row['id']}')),
                  DataCell(Text('${row['title']}')),
                  DataCell(Text('${row['sub_title']}')),
                  DataCell(Image.network(
                    "${row['image_link']}",
                    width: MediaQuery.of(context).size.width / 2,
                  )),
                  DataCell(Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          editContentModalBottomSheetForBlogsCard(
                              row['id'],
                              row['title'],
                              row['sub_title'],
                              row['image_link'],
                              builderContext);
                          // editContentModalBottomSheetHeaderAndFooter(
                          //     row['id'], row['video_link'], builderContext);
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
                            showConfirmationDialog(
                                builderContext, 'Content Deleted');
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

Future<void> editContentModalBottomSheetForBlogsCard(int id, String title,
    String subTitle, String imageLink, BuildContext context) async {
  final supabase = Supabase.instance.client;
  TextEditingController titleController = TextEditingController(text: title);
  TextEditingController subTitleController =
      TextEditingController(text: subTitle);
  TextEditingController imageLinkController =
      TextEditingController(text: imageLink);

  File? pickedImage; // Add a variable to store the picked image file

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Set the picked image file path to the image controller
      imageLinkController.text = pickedFile.path;
      pickedImage = File(pickedFile.path); // Store the picked image file
    }
  }

  Future<void> uploadImageAndHandleUpdate(int id, String imagePath,
      String title, String subTitle, BuildContext context) async {
    final file = File(imagePath);
    final random = const Uuid().v1();
    String defaultHalfPath =
        "https://kclsmsgznxxrnboeopjw.supabase.co/storage/v1/object/public";
    final response = await supabase.storage
        .from('blogs_images')
        .upload('public/$random.jpg', file); // Use a unique filename

    // Update the content in Supabase with the new image link
    String fullImageLink = "$defaultHalfPath/blogs_images/public/$random.jpg";
    final updateResponse = await supabase.from('blogs_card').update({
      'title': title,
      'sub_title': subTitle,
      'image_link': fullImageLink, // Use the key from the storage response
    }).match({'id': id});
  }

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
                      'Edit Blogs Card',
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: pickedImage != null
                                ? Image.file(
                                    pickedImage!,
                                    height: 100,
                                  )
                                : Image.network(
                                    imageLinkController.text.trim(),
                                    height: 100,
                                  )),
                        IconButton(
                          icon: const Icon(Icons.image),
                          onPressed: _pickImage,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: titleController,
                      decoration: const InputDecoration(labelText: 'Title'),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: subTitleController,
                      decoration: const InputDecoration(labelText: 'Sub Title'),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        uploadImageAndHandleUpdate(
                            id,
                            imageLinkController.text.trim(),
                            titleController.text.trim(),
                            subTitleController.text.trim(),
                            context);
                        // Update the content in Supabase
                        // final response =
                        //     await supabase.from('header_footer_video').update({
                        //   'video_link': linkController.text,
                        // }).match({'id': id});

                        // Content updated successfully
                        Navigator.pop(context); // Close the bottom sheet
                        showConfirmationDialog(context, 'Blogs Card Updated');
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

Future<void> addContentModalBottomSheetForBlogsCard(
    String counselling, BuildContext context) async {
  final supabase = Supabase.instance.client;
  TextEditingController titleController = TextEditingController(text: "");
  TextEditingController subTitleController = TextEditingController(text: "");
  TextEditingController imageLinkController = TextEditingController(text: "");

  File? pickedImage; // Add a variable to store the picked image file

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Set the picked image file path to the image controller
      imageLinkController.text = pickedFile.path;
      pickedImage = File(pickedFile.path); // Store the picked image file
    }
  }

  Future<void> uploadImageAndHandleUpdate(String imagePath, String title,
      String subTitle, BuildContext context) async {
    final file = File(imagePath);
    final random = const Uuid().v1();
    String defaultHalfPath =
        "https://kclsmsgznxxrnboeopjw.supabase.co/storage/v1/object/public";
    final String response = await supabase.storage
        .from('blogs_images')
        .upload('public/$random.jpg', file); // Use a unique filename

    // Update the content in Supabase with the new image link
    String fullImageLink = "$defaultHalfPath/blogs_images/public/$random.jpg";
    final updateResponse = await supabase.from('blogs_card').insert({
      'title': title,
      'sub_title': subTitle,
      'image_link': fullImageLink,
      'counselling': counselling // Use the key from the storage response
    });
  }

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
                      'Add Blogs Card',
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    // Display the picked image if available
                    pickedImage != null
                        ? Image.file(
                            pickedImage!,
                            height: 100, // Adjust the height as needed
                          )
                        : const SizedBox(),
                    const SizedBox(height: 16),
                    IconButton(
                      icon: const Icon(
                        Icons.image,
                        size: 35,
                      ),
                      onPressed: _pickImage,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: titleController,
                      decoration: const InputDecoration(labelText: 'Title'),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: subTitleController,
                      decoration: const InputDecoration(labelText: 'Sub Title'),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        await uploadImageAndHandleUpdate(
                            imageLinkController.text.trim(),
                            titleController.text.trim(),
                            subTitleController.text.trim(),
                            context);

                        // Content updated successfully
                        Navigator.pop(context); // Close the bottom sheet
                        showConfirmationDialog(context, 'Blogs Card Added');
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

Widget showDataTableForHeaderAndFooter(String section) {
  String hiveBoxName =
      section == "HEADER" ? "headerVideoIds" : "footerVideoIds";
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
          addContentModalBottomSheetHeaderAndFooter(
              section, builderContext, hiveBoxName);
        },
        child: const Text('Add New'),
      ),
      const SizedBox(height: 16),
      FutureBuilder(
        // Fetch data using Supabase query
        future: supabase.from(tableName).select().eq(sectionColumn, section),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
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
                          editContentModalBottomSheetHeaderAndFooter(row['id'],
                              row['video_link'], builderContext, hiveBoxName);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          bool confirmDelete =
                              await showDeleteConfirmationDialog(context);
                          if (confirmDelete) {
                            Box box = Hive.box(hiveBoxName);
                            box.clear();
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
    int id, String link, BuildContext context, String hiveBoxName) async {
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
                      style: Theme.of(context).textTheme.titleLarge,
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

                        Box box = Hive.box(hiveBoxName);
                        box.clear();

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
    String section, BuildContext context, String hiveBoxName) {
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
                    style: Theme.of(context).textTheme.titleLarge,
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

                      Box box = Hive.box(hiveBoxName);
                      box.clear();

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
  String selectedCounsellingForVideos = "Select the counselling";
  String selectedCounsellingForTimeline = "Select the counselling";

  @override
  void dispose() {
    super.dispose();
  }

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
      body: ListView(
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
          const Divider(color: Colors.blue, thickness: 4, height: 15),
          const SizedBox(height: 20),
          Text(
            "Counselling Videos",
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
                selectedCounsellingForVideos = value;
              });
            },
            "Select Counselling",
            "Please Select the counselling that you want to explore",
            context,
          ),
          showDataTableForCounsellingVideos(selectedCounsellingForVideos),
          const Divider(color: Colors.blue, thickness: 4, height: 15),
          const SizedBox(height: 20),
          Text(
            "Counselling TimeTable",
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
                selectedCounsellingForTimeline = value;
              });
            },
            "Select Counselling",
            "Please Select the counselling that you want to explore",
            context,
          ),
          showDataTableForCounsellingTimeline(selectedCounsellingForTimeline),
          const SizedBox(height: 100),
        ],
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

//Show Table For Counselling timeline
Widget showDataTableForCounsellingTimeline(String counselling) {
  print("Called the showData Table");
  final supabase = Supabase.instance.client;

  // Fetch data from Supabase based on the selected counselling
  const tableName = 'timeline';
  const counsellingColumn = 'counselling';

  return Builder(builder: (BuildContext builderContext) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      ElevatedButton(
        onPressed: () {
          // Implement your logic to add new data
          // This could include navigating to a new screen or showing a form
          // where the user can input new data.
          // For simplicity, I'm just printing a message here.
          // print('Add New Button Pressed');
          addContentModalBottomSheetForTimeline(counselling, builderContext);
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
            return const Center(child: CircularProgressIndicator());
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
              const DataColumn(label: Text('Date')),
              const DataColumn(label: Text('Time')),
              const DataColumn(label: Text('Order')),
              const DataColumn(label: Text('Actions')),
            ];

            // Define DataTable rows
            final rows = data.map<DataRow>((row) {
              return DataRow(
                cells: [
                  DataCell(Text('${row['id']}')),
                  DataCell(Text('${row['title']}')),
                  DataCell(SizedBox(
                    width: 150,
                    child: Text(
                      '${row['description']}',
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )),
                  DataCell(Text('${row['date']}')),
                  DataCell(Text('${row['time']}')),
                  DataCell(Text('${row['order']}')),
                  DataCell(Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          // Implement edit action
                          editContentModalBottomSheetForTimeline(
                              row['id'],
                              row['title'],
                              row['description'],
                              row['time'],
                              row['date'],
                              row['order'],
                              builderContext);
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
                                .from('timeline')
                                .delete()
                                .match({'id': row['id']});

                            // Content deleted successfully
                            showConfirmationDialog(
                                context, 'Timeline Deleted Successfully');
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

//Edit counselling Timeline
Future<void> editContentModalBottomSheetForTimeline(
    int id,
    String title,
    String description,
    String time,
    String date,
    String order,
    BuildContext context) async {
  final supabase = Supabase.instance.client;
  TextEditingController titleController = TextEditingController(text: title);
  TextEditingController descriptionController =
      TextEditingController(text: description);
  TextEditingController dateController = TextEditingController(text: date);
  TextEditingController timeController = TextEditingController(text: time);
  TextEditingController orderController = TextEditingController(text: order);

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
                      'Edit Counselling Timeline',
                      style: Theme.of(context).textTheme.titleLarge,
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
                      maxLines: 2,
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () async {
                        DateTime currentDate =
                            DateTime.parse(dateController.text);
                        DateTime? selectedDate = await showDatePicker(
                          context: context,
                          initialDate: currentDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2101),
                        );

                        if (selectedDate != null &&
                            selectedDate != currentDate) {
                          dateController.text =
                              selectedDate.toIso8601String().split('T')[0];
                        }
                      },
                      child: AbsorbPointer(
                        child: TextFormField(
                          controller: dateController,
                          decoration: const InputDecoration(labelText: 'Date'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () async {
                        TimeOfDay currentTime = TimeOfDay.now();

                        TimeOfDay? selectedTime = await showTimePicker(
                          context: context,
                          initialTime: currentTime,
                        );

                        if (selectedTime != null &&
                            selectedTime != currentTime) {
                          // Format the selected time to HH:mm format
                          String formattedTime =
                              "${selectedTime.hour}:${selectedTime.minute}";

                          // Update the timeController with the formatted time
                          timeController.text = formattedTime;
                        }
                      },
                      child: AbsorbPointer(
                        child: TextFormField(
                          controller: timeController,
                          decoration: const InputDecoration(labelText: 'Time'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: orderController,
                      decoration: const InputDecoration(labelText: 'Order'),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        // Update the content in Supabase
                        final response =
                            await supabase.from('timeline').update({
                          'title': titleController.text,
                          'description': descriptionController.text,
                          'time': timeController.text,
                          'date': dateController.text,
                          'order': orderController.text
                        }).match({'id': id});

                        // Content updated successfully
                        Navigator.pop(context); // Close the bottom sheet
                        showConfirmationDialog(context, 'Timeline Updated');
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

//Add counselling Timeline
Future<void> addContentModalBottomSheetForTimeline(
    String counselling, BuildContext context) async {
  final supabase = Supabase.instance.client;
  TextEditingController titleController = TextEditingController(text: "");
  TextEditingController descriptionController = TextEditingController(text: "");
  TextEditingController dateController = TextEditingController(text: "");
  TextEditingController timeController = TextEditingController(text: "");
  TextEditingController orderController = TextEditingController(text: "");

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
                      'Edit Counselling Timeline',
                      style: Theme.of(context).textTheme.titleLarge,
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
                      maxLines: 2,
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () async {
                        DateTime currentDate = DateTime.now();
                        DateTime? selectedDate = await showDatePicker(
                          context: context,
                          initialDate: currentDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2101),
                        );

                        if (selectedDate != null &&
                            selectedDate != currentDate) {
                          dateController.text =
                              selectedDate.toIso8601String().split('T')[0];
                        }
                      },
                      child: AbsorbPointer(
                        child: TextFormField(
                          controller: dateController,
                          decoration: const InputDecoration(labelText: 'Date'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () async {
                        TimeOfDay currentTime = TimeOfDay.now();

                        TimeOfDay? selectedTime = await showTimePicker(
                          context: context,
                          initialTime: currentTime,
                        );

                        if (selectedTime != null &&
                            selectedTime != currentTime) {
                          // Format the selected time to HH:mm format
                          String formattedTime =
                              "${selectedTime.hour}:${selectedTime.minute}";

                          // Update the timeController with the formatted time
                          timeController.text = formattedTime;
                        }
                      },
                      child: AbsorbPointer(
                        child: TextFormField(
                          controller: timeController,
                          decoration: const InputDecoration(labelText: 'Time'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: orderController,
                      decoration: const InputDecoration(labelText: 'Order'),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        // Update the content in Supabase
                        final response =
                            await supabase.from('timeline').insert({
                          'title': titleController.text,
                          'description': descriptionController.text,
                          'time': timeController.text,
                          'date': dateController.text,
                          'order': orderController.text,
                          'counselling': counselling
                        });

                        // Content updated successfully
                        Navigator.pop(context); // Close the bottom sheet
                        showConfirmationDialog(context, 'New Timeline Added');
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

//Show counselling videos
Widget showDataTableForCounsellingVideos(String counselling) {
  print("Called the showData Table");
  final supabase = Supabase.instance.client;

  // Fetch data from Supabase based on the selected counselling
  const tableName = 'counselling_videos';
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
          addVideosModalBottomSheet(counselling, builderContext);
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
            return const Center(child: CircularProgressIndicator());
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
              const DataColumn(label: Text('Video')),
              const DataColumn(label: Text('Actions')),
            ];

            // Define DataTable rows
            final rows = data.map<DataRow>((row) {
              return DataRow(
                cells: [
                  DataCell(Text('${row['id']}')),
                  DataCell(Text('${row['title']}')),
                  DataCell(Text('${row['video_link']}')),
                  DataCell(Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          // Implement edit action
                          editContentModalBottomSheetForVideos(row['id'],
                              row['title'], row['video_link'], builderContext);
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
                                .from('counselling_videos')
                                .delete()
                                .match({'id': row['id']});

                            // Content deleted successfully
                            showConfirmationDialog(context, 'Video Deleted');
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

//Edit counselling videos
Future<void> editContentModalBottomSheetForVideos(
    int id, String title, String videoLink, BuildContext context) async {
  final supabase = Supabase.instance.client;
  TextEditingController titleController = TextEditingController(text: title);
  TextEditingController videoLinkController =
      TextEditingController(text: videoLink);

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
                      'Edit Counselling Videos',
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: titleController,
                      decoration: const InputDecoration(labelText: 'Title'),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: videoLinkController,
                      decoration:
                          const InputDecoration(labelText: 'Video Link'),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        // Update the content in Supabase
                        final response =
                            await supabase.from('counselling_videos').update({
                          'title': titleController.text,
                          'video_link': videoLinkController.text,
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

//Add Counselling Videos
Future addVideosModalBottomSheet(String counselling, BuildContext context) {
  final supabase = Supabase.instance.client;
  TextEditingController titleController = TextEditingController(text: "");
  TextEditingController videoLinkController = TextEditingController(text: "");

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
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(labelText: 'Title'),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: videoLinkController,
                    decoration: const InputDecoration(labelText: 'Video Link'),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () async {
                      // Update the content in Supabase
                      final response =
                          await supabase.from('counselling_videos').insert({
                        'title': titleController.text.trim(),
                        'video_link': videoLinkController.text.trim(),
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
            return const Center(child: CircularProgressIndicator());
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
                      style: Theme.of(context).textTheme.titleLarge,
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
                      maxLines: 5,
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
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.green),
            ),
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
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.red),
                ),
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
                    style: Theme.of(context).textTheme.titleLarge,
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
                    maxLines: 5,
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
