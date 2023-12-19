import 'package:collegemitra/src/features/authentication/screens/counselling_features/features/all_colleges/widgets/about.dart';
import 'package:flutter/material.dart';

class PlacementsTab extends StatelessWidget {
  const PlacementsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Placements(),
          Recruiters(),
        ],
      ),
    );
  }
}

class Logos extends StatelessWidget {
  const Logos({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset("assets/logos/1.png", height: 40),
                Image.asset("assets/logos/2.png", height: 40),
                Image.asset("assets/logos/3.png", height: 40),
                Image.asset("assets/logos/5.png", height: 40),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset("assets/logos/4.png", height: 40),
                Image.asset("assets/logos/6.png", height: 40),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset("assets/logos/7.png", height: 40),
                Image.asset("assets/logos/9.png", height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Recruiters extends StatelessWidget {
  const Recruiters({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
          style: BorderStyle.solid,
          width: 3,
          color: Colors.deepOrange,
        ),
      ),
      elevation: 4,
      color: Colors.white,
      child: const Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recruiters',
              style: TextStyle(
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(1.0, 1.0),
                    blurRadius: 2.0,
                    color: Colors.black,
                  ),
                ],
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),
            Divider(
              color: Colors.deepOrange,
            ),
            Logos(),
          ],
        ),
      ),
    );
  }
}
