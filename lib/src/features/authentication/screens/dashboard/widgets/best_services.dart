import 'package:collegemitra/src/features/authentication/models/services_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BestServices extends StatelessWidget {
  const BestServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(featuredservices.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    // color: Theme.of(context).primaryColor.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(featuredservices[index].profile),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      featuredservices[index].name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(featuredservices[index].position),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 18,
                          color: Colors.yellow,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4, right: 6),
                          child: Text(
                            featuredservices[index].averageReview.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(featuredservices[index].totalReview),
                      ],
                    )
                  ],
                ),
              ],
            ),
          );
        }));
  }
}
