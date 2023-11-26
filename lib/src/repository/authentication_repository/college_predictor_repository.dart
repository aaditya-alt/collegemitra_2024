import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegemitra/src/features/authentication/models/user_model.dart';
import 'package:collegemitra/src/features/authentication/screens/counselling_features/features/college_predictor/show_colleges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CollegePredictorRepository extends GetxController {
  static CollegePredictorRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<CollegeData>> fetchCollegesAndRounds(
    String counselling,
    String category,
    String gender,
    int userRank,
  ) async {
    List<CollegeData> collegesData = [];

    try {
      QuerySnapshot collegeSnapshot = await _db
          .collection('Counselling')
          .doc(counselling)
          .collection('Colleges')
          .get();

      for (QueryDocumentSnapshot collegeDoc in collegeSnapshot.docs) {
        String collegeName = collegeDoc.id;

        List<BranchData> branchesData = [];

        QuerySnapshot branchSnapshot =
            await collegeDoc.reference.collection('Branches').get();

        for (QueryDocumentSnapshot branchDoc in branchSnapshot.docs) {
          String branchName = branchDoc.id;
          List<RoundData> roundsData = [];

          // Check if the branch has the specified category and gender
          QuerySnapshot roundSnapshot = await branchDoc.reference
              .collection("Category")
              .doc(category)
              .collection("SubCategory")
              .doc(gender)
              .collection("Rounds")
              .get();

          for (QueryDocumentSnapshot roundDoc in roundSnapshot.docs) {
            String roundName = roundDoc.id;

            dynamic openingRank = roundDoc.get('Opening Rank');
            dynamic closingRank = roundDoc.get('Closing Rank');

            if (openingRank is int) {
              // No need to parse, already an int
            } else if (openingRank is String) {
              openingRank = int.tryParse(openingRank);
            }

            if (closingRank is int) {
              // No need to parse, already an int
            } else if (closingRank is String) {
              closingRank = int.tryParse(closingRank);
            }

            if (openingRank != null && closingRank != null) {
              final rankDifference = closingRank - userRank;
              roundsData.add(
                RoundData(
                  roundName: roundName,
                  openingRank: openingRank,
                  closingRank: closingRank,
                  rankDifference: rankDifference,
                ),
              );
            }
          }

          branchesData.add(
            BranchData(
              branchName: branchName,
              rounds: roundsData,
            ),
          );
        }

        collegesData.add(
          CollegeData(
            collegeName: collegeName,
            collegeType: collegeName,
            branches: branchesData,
          ),
        );
      }

      return collegesData;
    } catch (e) {
      print('Error fetching data: $e');
      return [];
    }
  }
}
