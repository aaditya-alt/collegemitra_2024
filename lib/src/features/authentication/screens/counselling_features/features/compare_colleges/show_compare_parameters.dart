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
              "Average Placement Percentage",
              addPercentagePlacement(firstCollegedata[0].branchesFees)
                  .toString(),
              addPercentagePlacement(secondCollegedata[0].branchesFees)
                  .toString(),
              firstCollegedata[0].branchesFees.length * 100,
              secondCollegedata[0].branchesFees.length * 100),
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
                          "${(parseAndConvertToPercentage(firstParameter, firstbandWidthValue) * 100).ceil().toString()}%",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ),
                    Text(firstParameter,
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
                          "${(parseAndConvertToPercentage(secondParameter, secondbandWidthValue) * 100).ceil().toString()}%",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ),
                    Text(secondParameter,
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

double parseAndConvertToPercentage(String packageValue, double bandWidthValue) {
  try {
    // Remove non-numeric characters and convert to double
    double value =
        double.parse(packageValue.replaceAll(RegExp(r'[^0-9.]'), ''));

    // Assuming the maximum average package is 30 LPA
    return value / bandWidthValue;
  } catch (e) {
    // Handle parsing errors
    return 0.0;
  }
}

double addPercentagePlacement(List<Branch> branches) {
  return branches.fold(0.0, (finalValue, branch) {
    double value = double.parse(
        branch.percentagePlacement.replaceAll(RegExp(r'[^0-9.]'), ''));
    return finalValue + value;
  });
}
