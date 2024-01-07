import 'package:collegemitra/src/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DetailsScreen extends StatefulWidget {
  final counsellingName;

  const DetailsScreen({Key? key, required this.counsellingName})
      : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool isLoading = false;
  List<TextDetail> textDetails = [];

  @override
  void initState() {
    isLoading = true;
    _getData();
    super.initState();
  }

  void _getData() async {
    try {
      textDetails = await getDataFromDatabase(widget.counsellingName);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }

    // Set isLoading to false after fetching data
    // Trigger a rebuild
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

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
          'Know About ${widget.counsellingName}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: SafeArea(
        top: true,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height / 3.7,
                    width: size.width,
                    child: Image.asset(
                      "assets/images/features_images/about.jpeg",
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: size.height,
                    child: ListView.builder(
                        itemCount: textDetails.length,
                        itemBuilder: (context, i) {
                          return newInfocard(
                              context,
                              isDark,
                              textDetails[i].title,
                              textDetails[i].description,
                              textDetails[i].timestamp);
                        }),
                  )
                ],
              ),
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
      ),
    );
  }

  Widget counsellingDetailTiles(List<TextDetail> detail) {
    return ListView.builder(
      itemCount: detail.length,
      itemBuilder: (BuildContext context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 2, left: 0, right: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                // Change color as needed
                padding: const EdgeInsets.all(16.0),
                color: tPrimaryColor,
                child: Text(
                  detail[index].title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    border: Border.all(color: tPrimaryColor.shade200)),
                child: Text(
                  detail[index].description,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 17,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class TextDetail {
  final String title;
  final String description;
  final DateTime timestamp; // New field for timestamp

  TextDetail({
    required this.title,
    required this.description,
    required this.timestamp,
  });
}

getDataFromDatabase(String counselling) async {
  try {
    final supabase = Supabase.instance.client;
    final response = await supabase
        .from("counselling_information")
        .select()
        .eq("counselling", counselling);

    final List<dynamic>? data = response is List ? response : response['data'];

    if (data == null || data.isEmpty) {
      return [];
    }

    final List<TextDetail> textDetails = data
        .map<TextDetail>((row) => TextDetail(
              title: row['title'].toString(),
              description: row['description'].toString(),
              timestamp: DateTime.parse(
                  row['created_at'].toString()), // Parse timestamp
            ))
        .toList();

    return textDetails;
  } catch (e) {
    Get.snackbar(
      'Error',
      'Something went wrong. Try again',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent.withOpacity(0.1),
      colorText: Colors.red,
    );
    return [];
  }
}

Widget newInfocard(
  BuildContext context,
  isDark,
  String title,
  String description,
  DateTime timestamp,
) {
  return Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: Color(0xFF4B39EF),
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                width: 2,
                height: 160, // Adjust the height as needed
                color: const Color(0xFF4B39EF),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 12),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                  child: Text(
                    description,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RichText(
                        textScaleFactor: MediaQuery.of(context).textScaleFactor,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: DateFormat('EEE, MMM d').format(timestamp),
                              style: const TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                color: Color(0xFF57636C),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const TextSpan(
                              text: ' || ',
                              style: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                color: Color(0xFF57636C),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: DateFormat('h:mm a').format(timestamp),
                              style: const TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                color: Color(0xFF57636C),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
