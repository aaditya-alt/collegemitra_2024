//Creating modal to map user's data

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String? fullName;
  final String? email;
  final String? phoneNo;
  final String? password;

  const UserModel({
    this.id,
    required this.email,
    required this.password,
    required this.fullName,
    required this.phoneNo,
  });

  toJson() {
    return {
      "FullName": fullName,
      "Email": email,
      "Phone": phoneNo,
      "Password": password,
    };
  }

  //Step - 1 : Map User fetched from firebase to UserModal
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
        id: document.id,
        email: data["Email"],
        password: data["Password"],
        fullName: data["FullName"],
        phoneNo: data["Phone"]);
  }
}

class RoundData {
  final String roundName;
  final int openingRank;
  final int closingRank;
  final int rankDifference;

  RoundData({
    required this.roundName,
    required this.openingRank,
    required this.closingRank,
    required this.rankDifference,
  });
}

class BranchData {
  final String branchName;
  final List<RoundData> rounds;

  BranchData({
    required this.branchName,
    required this.rounds,
  });
}

class CollegeData {
  final String collegeName;
  final String collegeType;
  final List<BranchData> branches;

  CollegeData({
    required this.collegeName,
    required this.collegeType,
    required this.branches,
  });
}
