import 'package:collegemitra/src/constants/colors.dart';
import 'package:collegemitra/src/features/authentication/screens/counselling_features/features/rank_predictor/rank_predictor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';

Widget detailsDropdown(
  String hint,
  List<String> list,
  double mobileWidth,
  Function(String) onChanged,
  String title,
  String description,
  BuildContext context,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: mobileWidth - 95,
          child: DropDown(
            items: list,
            hint: Text(
              hint,
              style: const TextStyle(
                  overflow: TextOverflow.ellipsis, fontSize: 16),
            ),
            icon: const Icon(
              Icons.expand_more,
              color: Colors.blue,
            ),
            onChanged: (value) => onChanged(value!),
          ),
        ),
        GestureDetector(
          child: const Icon(
            Icons.info_rounded,
            size: 30,
            color: tAccentColor, // Change the color as needed
          ),
          onTap: () {
            showInformation(context, title, description);
          },
        ),
      ],
    ),
  );
}
