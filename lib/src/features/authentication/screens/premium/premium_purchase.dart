import 'package:collegemitra/src/features/authentication/screens/premium/dashboard/premium_dashboard.dart';
import 'package:collegemitra/src/features/authentication/screens/premium/widgets/parallex_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PremiumPurchase extends StatefulWidget {
  const PremiumPurchase({super.key});

  @override
  State<PremiumPurchase> createState() {
    return _PremiumPurchaseState();
  }
}

class _PremiumPurchaseState extends State<PremiumPurchase> {
  int currentIndex = -1, previousIndex = 0;

  double getAnimationValue(int currentIndex, int widgetIndex, int previousIndex,
      {bool begin = true}) {
    if (widgetIndex == currentIndex) {
      return begin ? 0.9 : 1;
    } else {
      return begin ? 1 : 0.9;
    }
  }

  void navigateToBuyPage(String product) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BuyPage(product)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 80, 64, 47),
            Color.fromARGB(255, 48, 39, 38),
            Color.fromARGB(255, 28, 22, 25),
            Color.fromARGB(255, 48, 39, 38),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          // title: Text(widget.title),
          title: Text(
            "Premium Plan",
            style: GoogleFonts.playfairDisplay(
              textStyle: const TextStyle(
                  color: Color.fromARGB(255, 255, 215, 0),
                  fontWeight: FontWeight.bold),
            ),
          ),
          centerTitle: true,
          foregroundColor: const Color.fromARGB(255, 255, 215, 0),
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text: 'Pick Your ',
                  style: GoogleFonts.playfairDisplay(
                    textStyle: const TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Premium',
                      style: GoogleFonts.playfairDisplay(
                        textStyle: const TextStyle(
                            color: Color.fromARGB(255, 255, 215, 0),
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const TextSpan(text: ' Plan'),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                child: const Text(
                  "We are excited to have you on board. You will be taking best decision of your life by opting our services you won't regret in future",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
              const ParallaxImages(),
              SizedBox(
                height: 300, // card height
                child: PageView.builder(
                  itemCount: 3,
                  controller: PageController(viewportFraction: 0.7),
                  onPageChanged: (int index) {
                    setState(() {
                      if (currentIndex != -1) {
                        previousIndex = currentIndex;
                      }
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (_, widgetIndex) {
                    List<String> cardTitles = ['Edge', 'Edge+', 'Edge Pro+'];
                    String currentTitle = cardTitles[widgetIndex];
                    List<String> featureOnes = [
                      'All Free Features',
                      'All Edge Features',
                      'All Edge+ Features'
                    ];
                    String featureOne = featureOnes[widgetIndex];
                    List<String> featureTwos = [
                      'College Predictor',
                      'Chat Support',
                      'Edge Pro+'
                    ];
                    String featureTwo = featureTwos[widgetIndex];
                    List<String> featureThrees = [
                      'Chat Support',
                      'Edge+',
                      'Edge Pro+'
                    ];
                    String featureThree = featureThrees[widgetIndex];
                    List<String> featureFours = ['EBook', 'Edge+', 'Edge Pro+'];
                    String featureFour = featureFours[widgetIndex];
                    List<String> prices = ['₹ 299', '₹ 499', '₹ 699'];
                    String price = prices[widgetIndex];

                    return TweenAnimationBuilder(
                      duration: const Duration(milliseconds: 400),
                      tween: Tween<double>(
                        begin: getAnimationValue(
                          currentIndex,
                          widgetIndex,
                          previousIndex,
                        ),
                        end: getAnimationValue(
                          currentIndex,
                          widgetIndex,
                          previousIndex,
                          begin: false,
                        ),
                      ),
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: value,
                          child: Card(
                            elevation: 6,
                            color: Colors.transparent,
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  color: Color.fromARGB(255, 178, 143, 76),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(25)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  currentTitle,
                                  style: GoogleFonts.playfairDisplay(
                                    textStyle: const TextStyle(
                                      fontSize: 30,
                                      color: Color.fromARGB(255, 255, 215, 0),
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.verified_rounded,
                                        color: Color.fromARGB(255, 255, 215, 0),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        featureOne,
                                        style: GoogleFonts.playfairDisplay(
                                          textStyle: const TextStyle(
                                            fontSize: 17,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.verified_rounded,
                                        color: Color.fromARGB(255, 255, 215, 0),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        featureTwo,
                                        style: GoogleFonts.playfairDisplay(
                                          textStyle: const TextStyle(
                                            fontSize: 17,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.verified_rounded,
                                        color: Color.fromARGB(255, 255, 215, 0),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        featureThree,
                                        style: GoogleFonts.playfairDisplay(
                                          textStyle: const TextStyle(
                                            fontSize: 17,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.verified_rounded,
                                        color: Color.fromARGB(255, 255, 215, 0),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        featureFour,
                                        style: GoogleFonts.playfairDisplay(
                                          textStyle: const TextStyle(
                                            fontSize: 17,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 5),
                                  child: Card(
                                    elevation: 6,
                                    color:
                                        const Color.fromARGB(255, 89, 71, 51),
                                    shape: RoundedRectangleBorder(
                                      // side: const BorderSide(
                                      //   color: Color.fromARGB(255, 77, 69, 129),
                                      //   width: 2,
                                      // ),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              25, 0, 0, 0),
                                          child: Text(
                                            price,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 230, 230, 230),
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 255, 215, 0),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15,
                                                horizontal:
                                                    25), // Adjust the vertical padding
                                          ),
                                          onPressed: () => Get.to(
                                              () => const PremiumDashboard()),
                                          child: const Text(
                                            "Buy Now",
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 32, 25, 38),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              // const SizedBox(
              //     child: Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Icon(Icons.copyright_rounded, color: Colors.white38),
              //     Text(
              //       " College Mitra  2022 - 2023",
              //       style: TextStyle(color: Colors.white38),
              //     )
              //   ],
              // ))
            ],
          ),
        ),
      ),
    );
  }
}

class BuyPage extends StatelessWidget {
  final String product;

  const BuyPage(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buy $product'),
      ),
      body: Center(
        child: Text('This is the page to buy $product'),
      ),
    );
  }
}
