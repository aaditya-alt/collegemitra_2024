import 'package:cached_network_image/cached_network_image.dart';
import 'package:collegemitra/src/constants/colors.dart';
import 'package:collegemitra/src/features/authentication/models/all_colleges_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CompareParameters extends StatelessWidget {
  final List<CollegeDetails> firstCollegedata;
  final List<CollegeDetails> secondCollegedata;
  const CompareParameters(
      {super.key,
      required this.firstCollegedata,
      required this.secondCollegedata});

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
        title: Text(
            "${firstCollegedata[0].collegeShortName} Vs ${secondCollegedata[0].collegeShortName}",
            style: Theme.of(context).textTheme.titleMedium),
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
        centerTitle: false,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(7, 0, 7, 5),
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
                padding: const EdgeInsetsDirectional.fromSTEB(13, 9, 13, 9),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: size.width / 3.5,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 78,
                                  height: 78,
                                  decoration: BoxDecoration(
                                    color: const Color(0x4D9489F5),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: const Color(0xFF6F61EF),
                                      width: 2,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            firstCollegedata[0].collegeImage,
                                        width: 90,
                                        height: 90,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 4, 0, 0),
                                  child: Text(
                                    firstCollegedata[0].collegeFullName,
                                    style: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      color: isDark
                                          ? Colors.white
                                          : const Color(0xFF14181B),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Stack(
                          alignment: const AlignmentDirectional(0, 0),
                          children: [
                            Align(
                              alignment: const AlignmentDirectional(0, 0),
                              child: Container(
                                width: 100,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE5E7EB),
                                  borderRadius: BorderRadius.circular(2),
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
                              alignment: const AlignmentDirectional(0, 0),
                              child: const Icon(
                                Icons.keyboard_double_arrow_right_rounded,
                                color: Color(0xFF606A85),
                                size: 32,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: size.width / 3.5,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 78,
                                  height: 78,
                                  decoration: BoxDecoration(
                                    color: const Color(0x4D9489F5),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: const Color(0xFF6F61EF),
                                      width: 2,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            secondCollegedata[0].collegeImage,
                                        width: 90,
                                        height: 90,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 4, 0, 0),
                                  child: Text(
                                    secondCollegedata[0].collegeFullName,
                                    style: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      color: isDark
                                          ? Colors.white
                                          : const Color(0xFF14181B),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
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
          const SizedBox(height: 10),
          cardForParameters(
              isDark,
              context,
              "Average package",
              firstCollegedata[0].averagePackage,
              secondCollegedata[0].averagePackage,
              30.0,
              30.0),
          const SizedBox(height: 15),
          cardForParameters(
              isDark,
              context,
              "Highest package",
              firstCollegedata[0].highestPackage,
              secondCollegedata[0].highestPackage,
              300.0,
              300.0),
          const SizedBox(height: 15),
          cardForParameters(
              isDark,
              context,
              "B.Tech Placement Percentage",
              addPercentagePlacement(firstCollegedata[0].branchesFees)
                  .toString(),
              addPercentagePlacement(secondCollegedata[0].branchesFees)
                  .toString(),
              firstCollegedata[0].branchesFees.length * 100,
              secondCollegedata[0].branchesFees.length * 100),
          const SizedBox(height: 15),
          cardForNormalInfo(
              isDark,
              context,
              "Yearly Fees",
              "Comparison On Fees",
              Icons.currency_rupee,
              firstCollegedata[0].imageUrlString[0],
              secondCollegedata[0].imageUrlString[0],
              firstCollegedata[0].branchesFees[0].fee,
              secondCollegedata[0].branchesFees[0].fee),
          const SizedBox(height: 15),
          cardForNormalInfo(
            isDark,
            context,
            "Campus Area",
            "Compus Area comparison",
            Icons.area_chart,
            firstCollegedata[0].imageUrlString[1],
            secondCollegedata[0].imageUrlString[1],
            firstCollegedata[0].campusArea,
            secondCollegedata[0].campusArea,
          ),
          const SizedBox(height: 15),
          cardForNormalInfo(
            isDark,
            context,
            "Ranking",
            "Rank comparison",
            Icons.leaderboard,
            firstCollegedata[0].imageUrlString[2],
            secondCollegedata[0].imageUrlString[2],
            firstCollegedata[0].ranking,
            secondCollegedata[0].ranking,
          ),
          const SizedBox(height: 15),
          cardForNormalInfo(
            isDark,
            context,
            "Establishment",
            "Establishment comparison",
            Icons.foundation,
            firstCollegedata[0].imageUrlString[3],
            secondCollegedata[0].imageUrlString[3],
            firstCollegedata[0].foundedIn,
            secondCollegedata[0].foundedIn,
          ),
          const SizedBox(height: 15),
          cardForNormalInfo(
            isDark,
            context,
            "Hostel Fee",
            "Hostel fee comparison",
            Icons.house,
            firstCollegedata[0].imageUrlString[0],
            secondCollegedata[0].imageUrlString[0],
            firstCollegedata[0].boysHostelFee,
            secondCollegedata[0].boysHostelFee,
          ),
          const SizedBox(height: 15),
          cardForNormalInfo(
            isDark,
            context,
            "Nearby Airport",
            "Nearby Airpor comparison",
            Icons.airplanemode_active,
            firstCollegedata[0].imageUrlString[1],
            secondCollegedata[0].imageUrlString[1],
            firstCollegedata[0].nearbyAirport,
            secondCollegedata[0].nearbyAirport,
          ),
          const SizedBox(height: 15),
          cardForNormalInfo(
            isDark,
            context,
            "Nearby Railway Station",
            "Nearby Railway comparison",
            Icons.directions_railway,
            firstCollegedata[0].imageUrlString[2],
            secondCollegedata[0].imageUrlString[2],
            firstCollegedata[0].nearbyRailway,
            secondCollegedata[0].nearbyRailway,
          ),
          const SizedBox(height: 15),
          cardForNormalInfo(
            isDark,
            context,
            "Nearby Bus Stand",
            "Nearby Bus comparison",
            Icons.bus_alert,
            firstCollegedata[0].imageUrlString[3],
            secondCollegedata[0].imageUrlString[3],
            firstCollegedata[0].nearbyBus,
            secondCollegedata[0].nearbyBus,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

Widget cardForParameters(
  isDark,
  BuildContext context,
  String title,
  String firstParameter,
  String secondParameter,
  double firstbandWidthValue,
  double secondbandWidthValue,
) {
  return Container(
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
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineSmall),
          const Divider(
            color: Colors.grey,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                      child: CircularPercentIndicator(
                        percent: parseAndConvertToPercentage(
                            firstParameter, firstbandWidthValue),
                        radius: 45,
                        lineWidth: 12,
                        animation: true,
                        animateFromLastPercent: true,
                        progressColor: const Color(0xFF4B39EF),
                        backgroundColor:
                            const Color.fromARGB(255, 229, 229, 229),
                        center: Text(
                          "${((parseAndConvertToPercentage(firstParameter, firstbandWidthValue) * 100).toDouble().ceil()).toString()}%",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ),
                    Text("$firstParameter of $firstbandWidthValue",
                        style: Theme.of(context).textTheme.titleSmall),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                      child: CircularPercentIndicator(
                        percent: parseAndConvertToPercentage(
                            secondParameter, secondbandWidthValue),
                        radius: 45,
                        lineWidth: 12,
                        animation: true,
                        animateFromLastPercent: true,
                        progressColor: const Color(0xFF4B39EF),
                        backgroundColor:
                            const Color.fromARGB(255, 229, 229, 229),
                        center: Text(
                          "${((parseAndConvertToPercentage(secondParameter, secondbandWidthValue) * 100).toDouble().ceil()).toString()}%",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ),
                    Text("$secondParameter of $secondbandWidthValue",
                        style: Theme.of(context).textTheme.titleSmall),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

double parseAndConvertToPercentage(
    String? packageValue, double bandWidthValue) {
  try {
    if (packageValue == null || bandWidthValue == 0) {
      return 0.0;
    }

    double value =
        double.tryParse(packageValue.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;

    double percentage = value / bandWidthValue;

    if (percentage.isNaN || percentage.isInfinite) {
      return 0.0;
    }

    return percentage;
  } catch (e) {
    return 0.0;
  }
}

double addPercentagePlacement(List<Branch?> branches) {
  return branches.fold(0.0, (finalValue, branch) {
    // ignore: unnecessary_null_comparison
    if (branch == null || branch.percentagePlacement == null) {
      return finalValue; // If branch or percentagePlacement is null, skip it
    }

    double value = double.tryParse(
            branch.percentagePlacement.replaceAll(RegExp(r'[^0-9.]'), '')) ??
        0.0;
    return (finalValue + value).toDouble();
  });
}

Widget cardForNormalInfo(
    isdark,
    BuildContext context,
    String title,
    String subTitle,
    IconData icon,
    String firstCollegeImages,
    String secondCollegeImages,
    String firstcollegeparameter,
    String secondcollegeparamenter) {
  var size = MediaQuery.of(context).size;
  return // Generated code for this Container Widget...
      Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: isdark
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
    child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 107, 146, 255),
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: const AlignmentDirectional(0, 0),
              child: Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 10),
            Text(title, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        const Divider(
          color: Colors.grey,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: size.width / 2.5,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 78,
                      height: 78,
                      decoration: BoxDecoration(
                        color: const Color(0x4D9489F5),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF6F61EF),
                          width: 2,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: CachedNetworkImage(
                            imageUrl: firstCollegeImages,
                            width: 90,
                            height: 90,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                      child: Text(
                        firstcollegeparameter,
                        style: Theme.of(context).textTheme.titleSmall,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: size.width / 2.5,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 78,
                      height: 78,
                      decoration: BoxDecoration(
                        color: const Color(0x4D9489F5),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF6F61EF),
                          width: 2,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: CachedNetworkImage(
                            imageUrl: secondCollegeImages,
                            width: 90,
                            height: 90,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                      child: Text(
                        secondcollegeparamenter,
                        style: Theme.of(context).textTheme.titleSmall,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );
}
