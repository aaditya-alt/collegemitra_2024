import 'dart:math';

import 'package:collegemitra/src/features/authentication/screens/meeting/video_call_screen.dart';
import 'package:collegemitra/src/features/authentication/screens/meeting/widgets/home_meeting_button.dart';
import 'package:collegemitra/src/repository/authentication_repository/meeting_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MeetingScreen extends StatelessWidget {
  MeetingScreen({super.key});

  final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();

  createNewMeeting() async {
    var random = Random();
    String roomName = (random.nextInt(10000000) + 10000000).toString();

    _jitsiMeetMethods.joinMeeting(
        roomName: roomName, isAudioMuted: true, isVideoMuted: true);
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              HomeMeetingButton(
                  icon: Icons.videocam,
                  text: 'New Meeting',
                  onPressed: createNewMeeting),
              HomeMeetingButton(
                icon: Icons.add_box_rounded,
                text: 'Join Meeting',
                onPressed: () {
                  Get.to(() => const VideoCallScreen());
                },
              ),
              HomeMeetingButton(
                icon: Icons.calendar_today,
                text: 'Schedule',
                onPressed: () {},
              ),
              HomeMeetingButton(
                icon: Icons.arrow_upward_rounded,
                text: 'Share Screen',
                onPressed: () {},
              ),
            ],
          ),
          const Expanded(
            child: Center(
              child: Text(
                "Create/Join Meetings with just a click!",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
