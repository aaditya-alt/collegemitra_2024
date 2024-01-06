import 'package:flutter/material.dart';

class MeetingOption extends StatelessWidget {
  final String text;
  final bool isMute;
  final Function(bool) onChange;
  const MeetingOption(
      {super.key,
      required this.text,
      required this.isMute,
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      height: 60,
      color: isDark ? Colors.black : Colors.grey.shade300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Switch.adaptive(value: isMute, onChanged: onChange),
        ],
      ),
    );
  }
}
