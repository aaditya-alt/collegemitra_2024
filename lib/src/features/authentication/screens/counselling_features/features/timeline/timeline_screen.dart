import 'package:collegemitra/src/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimeLineScreen extends StatefulWidget {
  final String counsellingName;
  const TimeLineScreen({super.key, required this.counsellingName});

  @override
  State<TimeLineScreen> createState() => _TimeLineScreenState();
}

class _TimeLineScreenState extends State<TimeLineScreen> {
  @override
  void initState() {
    isLoading = true;
    getTimelineData();
    super.initState();
  }

  bool isLoading = false;
  List<TimelineEvent> timelineDetails = [];

  getTimelineData() async {
    try {
      final data = await getTimelineEvents(widget.counsellingName);
      timelineDetails = data;
      timelineDetails
          .sort((a, b) => int.parse(a.order).compareTo(int.parse(b.order)));
    } catch (e) {
      debugPrint("Error in timeLine Page ${e.toString()}");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
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
          '${widget.counsellingName} Schedule',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 15),
                for (var event in timelineDetails)
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: timeLineCard(
                        isDark,
                        context,
                        event.isPast,
                        event.isPast ? Icons.done_all : Icons.cancel,
                        event.isPast ? tPrimaryColor : Colors.grey,
                        event.title,
                        event.description,
                        event.date,
                        event.time,
                        event.order,
                        event.order == "1" ? true : false),
                  ),
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
    );
  }
}

Widget timeLineCard(
    isDark,
    BuildContext context,
    bool isPast,
    IconData icon,
    Color color,
    String title,
    String description,
    String date,
    String time,
    String order,
    bool isFirst) {
  return Column(
    mainAxisSize: MainAxisSize.max,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TimelineTile(
        alignment: TimelineAlign.manual,
        lineXY: 0.1,
        isFirst: isFirst,
        indicatorStyle: IndicatorStyle(
          color: color,
          indicator: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: const AlignmentDirectional(0, 0),
            child: Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
        beforeLineStyle: LineStyle(
          color: color,
          thickness: 6,
        ),
        endChild: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              endchild(context, isDark, title, description, date, time, color),
        ),
      ),
    ],
  );
}

Widget endchild(
  BuildContext context,
  bool isDark,
  String title,
  String description,
  String date,
  String time,
  Color color,
) {
  // Convert date string to DateTime object
  DateTime eventDateTime = DateTime.parse('$date $time');

  // Format DateTime to a user-friendly date format
  String formattedDate = DateFormat.yMMMMd().format(eventDateTime);

  // Format DateTime to a user-friendly time format
  String formattedTime = DateFormat.jm().format(eventDateTime);

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isDark
            ? const Color.fromARGB(255, 10, 10, 10)
            : const Color.fromARGB(255, 245, 245, 245),
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            color: Color(0x3F14181B),
            offset: Offset(0, 3),
          )
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
              child: Text(
                description,
                style: Theme.of(context).textTheme.titleSmall,
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
              child: Text(
                '$formattedDate • $formattedTime', // Display formatted date and time
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: tPrimaryColor),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class TimelineEvent {
  final String title;
  final String description;
  final String date;
  final String time;
  final String order;
  final bool isPast;

  TimelineEvent({
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.order,
    required this.isPast,
  });
}

getTimelineEvents(String counselling) async {
  try {
    final supabase = Supabase.instance.client;
    final response =
        await supabase.from('timeline').select().eq('counselling', counselling);

    final List<dynamic>? data = response is List ? response : response['data'];

    if (data == null || data.isEmpty) {
      // Return an empty list if there is no data
      return [];
    }

    final List<TimelineEvent> timelineEvents = data.map<TimelineEvent>((row) {
      return TimelineEvent(
        title: row['title'].toString(),
        description: row['description'].toString(),
        date: row['date'].toString(),
        time: row['time'].toString(),
        isPast: DateTime.parse('${row['date']} ${row['time']}')
            .isBefore(DateTime.now()),
        order: row['order'].toString(),
      );
    }).toList();

    return timelineEvents;
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
