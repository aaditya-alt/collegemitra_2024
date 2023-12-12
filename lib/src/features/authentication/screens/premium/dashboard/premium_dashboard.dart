import 'package:collegemitra/src/repository/authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PremiumDashboard extends StatelessWidget {
  const PremiumDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthenticationRepository.instance;
    final userName = auth.userName;
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
          appBar: AppBar(
            title: Text(
              "$userName's Dashboard",
              style: GoogleFonts.playfairDisplay(
                textStyle: const TextStyle(
                    color: Color.fromARGB(255, 255, 215, 0),
                    fontWeight: FontWeight.bold),
              ),
            ),
            centerTitle: true,
          ),
          body: const SingleChildScrollView(
            child: Column(
              children: [
                ProfileCard(),
                ServicesCard(),
                MentorSection(),
                MoreInfo(),
              ],
            ),
          ),
        ));
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: SizedBox(
        height: 150,
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25))),
          color: Color.fromARGB(255, 255, 229, 107),
          elevation: 5,
          shadowColor: Color.fromARGB(124, 199, 197, 132),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Welcome Back",
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
                  ),
                  Text(
                    "Rohit Tiwari",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Glad to see you again",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  )
                ],
              ),
              Image(
                image: AssetImage("assets/1.png"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ServicesCard extends StatelessWidget {
  const ServicesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25))),
        color: const Color.fromARGB(255, 255, 229, 107),
        elevation: 5,
        shadowColor: const Color.fromARGB(124, 199, 197, 132),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Card(
                    color: Color.fromARGB(128, 255, 255, 229),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.messenger),
                      iconSize: 50,
                    ),
                  ),
                  const Text("Chat")
                ],
              ),
              Column(
                children: [
                  Card(
                    color: const Color.fromARGB(128, 255, 255, 229),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.newspaper_rounded),
                      iconSize: 50,
                    ),
                  ),
                  const Text("News"),
                ],
              ),
              Column(
                children: [
                  Card(
                    color: const Color.fromARGB(128, 255, 255, 229),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.video_call_rounded),
                      iconSize: 50,
                    ),
                  ),
                  const Text("Video Chat")
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MentorSection extends StatelessWidget {
  const MentorSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: SizedBox(
        height: 100,
        child: Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25))),
          color: const Color.fromARGB(255, 255, 229, 107),
          elevation: 5,
          shadowColor: const Color.fromARGB(124, 199, 197, 132),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Your Mentor",
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
                  ),
                  Text(
                    "Gautam Kumar",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 5,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add_ic_call_sharp),
                iconSize: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MoreInfo extends StatelessWidget {
  const MoreInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: SizedBox(
        width: 700,
        child: Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25))),
          color: const Color.fromARGB(255, 255, 229, 107),
          elevation: 5,
          shadowColor: const Color.fromARGB(124, 199, 197, 132),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    print("object");
                  },
                  child: const Card(
                    color: Color.fromARGB(128, 255, 255, 229),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.edit_note_rounded,
                            size: 30,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Request Form Filling",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print("object");
                  },
                  child: const Card(
                    color: Color.fromARGB(128, 255, 255, 229),
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.edit_attributes_rounded,
                            size: 30,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text("Choice Filling",
                              style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print("object");
                  },
                  child: const Card(
                    color: Color.fromARGB(128, 255, 255, 229),
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.groups,
                            size: 30,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text("Upcoming meetings",
                              style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print("object");
                  },
                  child: const Card(
                    color: Color.fromARGB(128, 255, 255, 229),
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_month,
                            size: 30,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text("Key Dates", style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print("object");
                  },
                  child: const Card(
                    color: Color.fromARGB(128, 255, 255, 229),
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.account_circle,
                            size: 30,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text("Account Info", style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
