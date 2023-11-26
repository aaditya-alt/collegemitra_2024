import 'dart:developer';

import 'dart:ui';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:collegemitra/src/constants/colors.dart';
import 'package:collegemitra/src/features/authentication/controllers/rank_predictor_controller.dart';
import 'package:collegemitra/src/features/authentication/screens/general_utils/carousel_slider.dart';
import 'package:collegemitra/src/features/authentication/screens/welcome/animated_button.dart';
import 'package:easy_loader/easy_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';

class RankPredictor extends StatefulWidget {
  var counsellingName;
  RankPredictor({super.key, this.counsellingName});

  @override
  State<RankPredictor> createState() => _RankPredictorState();
}

class _RankPredictorState extends State<RankPredictor> {
  late RiveAnimationController _btnAnimationController;
  bool isLoading = false;

  String examdate = "20 Feb 2023";
  String examShift = "1st Shift";

  @override
  void initState() {
    _btnAnimationController = OneShotAnimation(
      "active",
      autoplay: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(RankPredictorController());
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final size = MediaQuery.of(context).size.width;
    var counselling;

    if (widget.counsellingName == "GGSIPU Delhi") {
      counselling = "GGSIPU";
    } else if (widget.counsellingName == "JAC Delhi") {
      counselling = "JACD";
    } else {
      counselling = widget.counsellingName;
    }

    List<String> dates = [
      '20 Feb 2023',
      '21 Feb 2023',
      '22 Feb 2023',
      '24 Feb 2023',
    ];

    List<String> shift = [
      '1st Shift',
      '2nd Shift',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "JEE Mains 2024 Rank Predictor",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned(
            width: size * 1.7,
            left: 100,
            bottom: 100,
            child: Image.asset(
              "assets/images/spline.png",
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 45),
              child: const SizedBox(),
            ),
          ),
          const RiveAnimation.asset(
            "assets/images/riveAssets/shapes.riv",
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: const SizedBox(),
            ),
          ),
          AnimatedPositioned(
            top: 0,
            height: MediaQuery.of(context).size.height,
            width: size,
            duration: const Duration(milliseconds: 260),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      const MyCarouselSlider(),
                      const SizedBox(height: 15),
                      detailsDropdown("Select your exam date", dates, size,
                          (value) {
                        setState(() {
                          examdate = value;
                        });
                      }, "JEE Mains 2024 Exam Date",
                          "Enter the Correct details about the date when your JEE Mains 2024 exam were held."),
                      detailsDropdown("Select your shift", shift, size,
                          (value) {
                        setState(() {
                          examShift = value;
                        });
                      }, "JEE Mains 2024 Exam Shift",
                          "Enter the correct shift detail about on the selected date which shift was yours like it could be one from the given option, please choose carefully."),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 56, top: 12, bottom: 12),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _controller.marks,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.elliptical(10, 10)),
                              ),
                              label: Text("Enter Expected marks"),
                              prefixIcon: Icon(Icons.fingerprint)),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    child: AnimatedBtn(
                      btnAnimationController: _btnAnimationController,
                      press: () {
                        setState(() {
                          isLoading = true;
                        });
                        _btnAnimationController.isActive = true;

                        // _controller.printDetails(
                        //     examdate, examShift, _controller.marks.text);

                        String dificulty =
                            decideDifficulty(examdate, examShift);

                        double marks = double.parse(_controller.marks.text);

                        if (!marks.isNaN) {
                          calculateScore(dificulty, 900000, marks, context);
                        } else {
                          Get.snackbar("Error", "Please Enter a valid marks");
                        }

                        // Get.to(() => const LoginScreen());

                        // Future.delayed(
                        //   const Duration(milliseconds: 800),
                        //   () {
                        //     setState(() {
                        //       isShowSignInDialog = true;
                        //     });
                        //   },
                        // );
                        setState(() {
                          isLoading = false;
                        });
                      },
                      buttonText: "Predict my rank",
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24, horizontal: 14),
                    child: Text(
                      "Counselling support & Guidance, College Cutoff details and College Features and comparing different colleges.",
                      style: TextStyle(
                          fontSize: 12, color: Color.fromARGB(255, 78, 78, 78)),
                    ),
                  )
                ],
              ),
            ),
          ),
          Visibility(
            visible: isLoading,
            child: Container(
              color:
                  Colors.black.withOpacity(0.5), // Adjust the opacity as needed
              child: Center(
                child: Image.asset(
                  "assets/gif/loader.gif",
                  width: size / 4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget detailsDropdown(String hint, List<String> list, double mobileWidth,
      Function(String) onChanged, String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: mobileWidth - 80,
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
              color: Colors.yellow,
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
}

String decideDifficulty(String examDate, String examShift) {
  String dificulty;

  if (examDate == "20 Feb 2023" && examShift == "1st Shift") {
    dificulty = "Easy";
  } else if (examDate == "20 Feb 2023" && examShift == "2nd Shift") {
    dificulty = "Medium";
  } else if (examDate == "21 Feb 2023" && examShift == "1st Shift") {
    dificulty = "Very Hard";
  } else if (examDate == "21 Feb 2023" && examShift == "2nd Shift") {
    dificulty = "Medium";
  } else if (examDate == "22 Feb 2023" && examShift == "1st Shift") {
    dificulty = "Very Easy";
  } else if (examDate == "22 Feb 2023" && examShift == "2nd Shift") {
    dificulty = "Medium";
  } else if (examDate == "23 Feb 2023" && examShift == "1st Shift") {
    dificulty = "Easy";
  } else if (examDate == "23 Feb 2023" && examShift == "2nd Shift") {
    dificulty = "Very Hard";
  } else if (examDate == "24 Feb 2023" && examShift == "1st Shift") {
    dificulty = "Medium";
  } else if (examDate == "24 Feb 2023" && examShift == "2nd Shift") {
    dificulty = "Hard";
  } else {
    dificulty = "";
  }

  return dificulty;
}

calculateScore(
    String dificulty, double candidates, double marks, BuildContext context) {
  double a = marks;
  double n = candidates;

  double b = 0;
  double g = 0.0;
  double c = 0;
  if (dificulty == "Very Easy") {
    g = 0.18;
  } else if (dificulty == "Easy") {
    g = 0.15175;
  } else if (dificulty == "Medium") {
    g = 0.1165;
  } else if (dificulty == "Hard") {
    g = 0.05275;
  } else if (dificulty == "Very Hard") {
    g = -0.09;
  }

  if (a <= 180) {
    a = a - a * g;
  } else {
    a = a - (300 - a) * g * 180 / 120;
  }

  if (a < (-60)) {
    a = -60;
  }
  if (a > 300) {
    a = 300;
  }

  if (a < 0) {
    c = (((100 - 6) / 100) * n + 1);
  } else {
    if (a <= 40) {
      b = 69.5797271 - 6;
      b = (a - 0) * b / (40 - 0) + 6;
    } else if (a <= 61) {
      b = 84.22540213 - 69.5797271;
      b = (a - 40) * b / (61 - 40) + 69.5797271;
    } else if (a <= 87) {
      b = 91.59517945 - 84.22540213;
      b = (a - 61) * b / (87 - 61) + 84.22540213;
    } else if (a <= 94) {
      b = 92.88745828 - 91.59517945;
      b = (a - 87) * b / (94 - 87) + 91.59517945;
    } else if (a <= 101) {
      b = 93.89928202 - 92.88745828;
      b = (a - 94) * b / (101 - 94) + 92.88745828;
    } else if (a <= 109) {
      b = 94.96737888 - 93.89928202;
      b = (a - 101) * b / (109 - 101) + 93.89928202;
    } else if (a <= 119) {
      b = 95.983027 - 94.96737888;
      b = (a - 109) * b / (119 - 109) + 94.96737888;
    } else if (a <= 131) {
      b = 96.93721175 - 95.983027;
      b = (a - 119) * b / (131 - 119) + 95.983027;
    } else if (a <= 148) {
      b = 97.97507774 - 96.93721175;
      b = (a - 131) * b / (148 - 131) + 96.93721175;
    } else if (a <= 159) {
      b = 98.49801724 - 97.97507774;
      b = (a - 148) * b / (159 - 148) + 97.97507774;
    } else if (a <= 174) {
      b = 98.99673561 - 98.49801724;
      b = (a - 159) * b / (174 - 159) + 98.49801724;
    } else if (a <= 188) {
      b = 99.3487614 - 98.99673561;
      b = (a - 174) * b / (188 - 174) + 98.99673561;
    } else if (a <= 199) {
      b = 99.56019541 - 99.3487614;
      b = (a - 188) * b / (199 - 188) + 99.3487614;
    } else if (a <= 214) {
      b = 99.73930423 - 99.56019541;
      b = (a - 199) * b / (214 - 199) + 99.56019541;
    } else if (a <= 230) {
      b = 99.87060821 - 99.73930423;
      b = (a - 214) * b / (230 - 214) + 99.73930423;
    } else if (a <= 249) {
      b = 99.95028296 - 99.87060821;
      b = (a - 230) * b / (249 - 230) + 99.87060821;
    } else if (a <= 267) {
      b = 99.99016586 - 99.95028296;
      b = (a - 249) * b / (267 - 249) + 99.95028296;
    } else if (a <= 279) {
      b = 99.99417236 - 99.99016586;
      b = (a - 267) * b / (279 - 267) + 99.99016586;
    } else if (a <= 284) {
      b = 99.99790569 - 99.99417236;
      b = (a - 279) * b / (284 - 279) + 99.99417236;
    } else if (a <= 292) {
      b = 99.99890732 - 99.99790569;
      b = (a - 284) * b / (292 - 284) + 99.99790569;
    } else if (a <= 300) {
      b = 100 - 99.99890732;
      b = (a - 292) * b / (300 - 292) + 99.99890732;
    }
    c = ((100 - b) / 100) * n + 1;
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero, // No content padding
        backgroundColor: Colors.transparent, // Transparent background
        content: Container(
          width: double.maxFinite, // Full-width dialog
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding:
                const EdgeInsets.all(8.0), // Padding for the dialog content
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/gif/graduation-cap.gif",
                  height: 100,
                  width: 100,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Card(
                        color: Colors.blue, // Left card color
                        elevation: 8.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Expected Percentile',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${b.toPrecision(3)}',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16), // Spacer between cards
                    Expanded(
                      child: Card(
                        color: Colors.blue, // Right card color
                        elevation: 8.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Expected Rank',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${c.toInt()}',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                const Text(
                  'algorithm designed by Collegemitra',
                  style: TextStyle(
                    color: Color.fromARGB(137, 85, 85, 85),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Future<void> showInformation(
    BuildContext context, String title, String description) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16.0)),
                  child: Image.asset(
                    "assets/gif/faq.gif",
                    width: double.maxFinite,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.lato(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        description,
                        style: GoogleFonts.lato(
                            fontSize: 18,
                            color: Colors.black87,
                            fontStyle: FontStyle.italic),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Future showWait(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Container(
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: const CircularProgressIndicator()),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      child: const Text(
                        "LOADING...",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ));
      });
}
