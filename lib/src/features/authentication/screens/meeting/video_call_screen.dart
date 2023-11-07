import 'package:collegemitra/src/constants/colors.dart';
import 'package:collegemitra/src/features/authentication/screens/meeting/widgets/meeting_options.dart';
import 'package:collegemitra/src/repository/authentication_repository/authentication_repository.dart';
import 'package:collegemitra/src/repository/authentication_repository/meeting_repository.dart';
import 'package:collegemitra/src/repository/authentication_repository/user_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  late TextEditingController meetingIDController;
  final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();

  bool isAudioMuted = true;
  bool isVideoMuted = true;

  @override
  void initState() {
    meetingIDController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    meetingIDController.dispose();
  }

  _joinMeeting() {
    _jitsiMeetMethods.joinMeeting(
        roomName: meetingIDController.text,
        isAudioMuted: isAudioMuted,
        isVideoMuted: isVideoMuted);
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: tPrimaryColor.shade100,
        foregroundColor: isDark ? Colors.black : Colors.white,
        title: const Text(
          "Join a Meeting",
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Column(
          children: [
            SizedBox(
              height: 60,
              child: TextField(
                controller: meetingIDController,
                maxLines: 1,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  fillColor: Colors.grey,
                  filled: true,
                  border: InputBorder.none,
                  hintText: "Room ID",
                ),
              ),
            ),
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ElevatedButton(
                style: const ButtonStyle(
                    elevation: MaterialStatePropertyAll(4),
                    backgroundColor: MaterialStatePropertyAll(tPrimaryColor),
                    foregroundColor: MaterialStatePropertyAll(Colors.black),
                    padding: MaterialStatePropertyAll(EdgeInsets.only(
                        left: 10, right: 10, top: 3, bottom: 3))),
                onPressed: _joinMeeting,
                child: Text(
                  "Join Now",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            const SizedBox(height: 20),
            MeetingOption(
              text: 'Don\'t join with Audio',
              isMute: isAudioMuted,
              onChange: onAudioMuted,
            ),
            MeetingOption(
              text: 'Turn Off My Video',
              isMute: isVideoMuted,
              onChange: onVideoMuted,
            ),
          ],
        ),
      ),
    );
  }

  onAudioMuted(bool val) {
    setState(() {
      isAudioMuted = val;
    });
  }

  onVideoMuted(bool val) {
    setState(() {
      isVideoMuted = val;
    });
  }
}
