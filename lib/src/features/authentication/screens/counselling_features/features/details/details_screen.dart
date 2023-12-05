import 'package:collegemitra/src/constants/colors.dart';
import 'package:flutter/material.dart';
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
    textDetails = await getDataFromDatabase(widget.counsellingName);
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
        title: Text("About ${widget.counsellingName}"),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: size.height / 3.7,
                width: size.width,
                child: Image.asset(
                  "assets/images/features_images/about.jpeg",
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: counsellingDetailTiles(textDetails),
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

  TextDetail({
    required this.title,
    required this.description,
  });
}

Future<List<TextDetail>> getDataFromDatabase(String counselling) async {
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
          ))
      .toList();

  return textDetails;
}
