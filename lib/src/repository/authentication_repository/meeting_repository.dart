import 'package:collegemitra/src/repository/authentication_repository/authentication_repository.dart';
import 'package:collegemitra/src/repository/authentication_repository/user_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';

class JitsiMeetMethods {
  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());
  final _jitsiMeetPlugin = JitsiMeet();

  void join(
      {required String roomName,
      required bool isAudioMuted,
      required bool isVideoMuted}) async {
    final email = _authRepo.firebaseUser.value?.email;
    final userDetails = await _userRepo.getUserDetails(email!);
    try {
      var options = JitsiMeetConferenceOptions(
        room: "testgabigabi",
        configOverrides: {
          "startWithAudioMuted": false,
          "startWithVideoMuted": false,
          "subject": "Lipitori"
        },
        featureFlags: {
          "unsaferoomwarning.enabled": false,
          "ios.screensharing.enabled": true
        },
        userInfo: JitsiMeetUserInfo(
            displayName: userDetails.fullName,
            email: userDetails.email,
            avatar:
                "https://avatars.githubusercontent.com/u/57035818?s=400&u=02572f10fe61bca6fc20426548f3920d53f79693&v=4"),
      );

      var listener = JitsiMeetEventListener(
        conferenceJoined: (url) {
          debugPrint("conferenceJoined: url: $url");
        },
        conferenceTerminated: (url, error) {
          debugPrint("conferenceTerminated: url: $url, error: $error");
        },
        conferenceWillJoin: (url) {
          debugPrint("conferenceWillJoin: url: $url");
        },
        // participantJoined: (email, name, role, participantId) {
        //   debugPrint(
        //     "participantJoined: email: $email, name: $name, role: $role, "
        //     "participantId: $participantId",
        //   );
        //   participants.add(participantId!);
        // },
        participantLeft: (participantId) {
          debugPrint("participantLeft: participantId: $participantId");
        },
        audioMutedChanged: (muted) {
          debugPrint("audioMutedChanged: isMuted: $muted");
        },
        videoMutedChanged: (muted) {
          debugPrint("videoMutedChanged: isMuted: $muted");
        },
        endpointTextMessageReceived: (senderId, message) {
          debugPrint(
              "endpointTextMessageReceived: senderId: $senderId, message: $message");
        },
        screenShareToggled: (participantId, sharing) {
          debugPrint(
            "screenShareToggled: participantId: $participantId, "
            "isSharing: $sharing",
          );
        },
        chatMessageReceived: (senderId, message, isPrivate, timestamp) {
          debugPrint(
            "chatMessageReceived: senderId: $senderId, message: $message, "
            "isPrivate: $isPrivate, timestamp: $timestamp",
          );
        },
        chatToggled: (isOpen) => debugPrint("chatToggled: isOpen: $isOpen"),
        participantsInfoRetrieved: (participantsInfo) {
          debugPrint(
              "participantsInfoRetrieved: participantsInfo: $participantsInfo, ");
        },
        readyToClose: () {
          debugPrint("readyToClose");
        },
      );
      await _jitsiMeetPlugin.join(options, listener);
    } catch (error) {
      print("error: $error");
    }
  }
}
