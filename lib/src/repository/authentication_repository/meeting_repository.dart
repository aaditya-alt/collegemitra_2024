import 'package:collegemitra/src/repository/authentication_repository/authentication_repository.dart';
import 'package:collegemitra/src/repository/authentication_repository/user_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';

class JitsiMeetMethods {
  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());
  final _jitsiMeetPlugin = JitsiMeet();

  void joinMeeting(
      {required String roomName,
      required bool isAudioMuted,
      required bool isVideoMuted}) async {
    final email = _authRepo.firebaseUser.value?.email;
    final userDetails = await _userRepo.getUserDetails(email!);
    try {
      var options = JitsiMeetConferenceOptions(
        room: roomName,
        configOverrides: {
          "startWithAudioMuted": isAudioMuted,
          "startWithVideoMuted": isVideoMuted,
          "subject": "Collegemitra Meeting"
        },
        featureFlags: {
          "unsaferoomwarning.enabled": false,
          "ios.screensharing.enabled": true
        },
        userInfo: JitsiMeetUserInfo(
            displayName: userDetails.fullName,
            email: userDetails.email,
            avatar:
                "https://tse3.mm.bing.net/th?id=OIP.ucv1JnCWKWjgS83JX0xBKQHaE6&pid=Api&P=0&h=180"),
      );

      await _jitsiMeetPlugin.join(options);
    } catch (error) {
      print("error: $error");
    }
  }
}
