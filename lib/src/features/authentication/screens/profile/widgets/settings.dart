import 'package:collegemitra/src/constants/colors.dart';
import 'package:collegemitra/src/features/authentication/models/settings_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SettWidget extends StatefulWidget {
  final String? email;
  const SettWidget({Key? key, required this.email}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SettWidgetState createState() => _SettWidgetState();
}

class _SettWidgetState extends State<SettWidget> {
  final SettController _controller = Get.put(SettController());
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool pushNotifications = false;
  bool emailNotifications = false;
  Box? userDataBox;

  @override
  void initState() {
    super.initState();
    userDataBox = Hive.box(widget.email.toString());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        automaticallyImplyLeading: false,
        leading: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            Get.back();
          },
          child: Icon(
            Icons.chevron_left_rounded,
            color: isDark ? Colors.white : const Color(0xFF14181B),
            size: 32,
          ),
        ),
        title: Text(
          'Settings Page',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
            child: Obx(
              () => SwitchListTile.adaptive(
                value: _controller.switchListTileValue1.value,
                onChanged: (value) {
                  _controller.switchListTileValue1.value = value;
                  setState(() {
                    pushNotifications = value;
                  });
                },
                title: Text('Push Notifications',
                    style: Theme.of(context).textTheme.titleMedium),
                subtitle: Text(
                    'Receive Push notifications from our application on a semi regular basis.',
                    style: Theme.of(context).textTheme.titleSmall),
                tileColor: isDark ? Colors.black : Colors.white,
                activeColor: tPrimaryColor,
                activeTrackColor: tPrimaryColor.shade100,
                dense: false,
                controlAffinity: ListTileControlAffinity.trailing,
                contentPadding:
                    const EdgeInsetsDirectional.fromSTEB(24, 12, 24, 12),
              ),
            ),
          ),
          Obx(
            () => SwitchListTile.adaptive(
              value: _controller.switchListTileValue2.value,
              onChanged: (value) {
                _controller.switchListTileValue2.value = value;
                setState(() {
                  emailNotifications = value;
                });
              },
              title: Text('Email Notifications',
                  style: Theme.of(context).textTheme.titleMedium),
              subtitle: Text(
                  'Receive email notifications from our marketing team about new features.',
                  style: Theme.of(context).textTheme.titleSmall),
              tileColor: isDark ? Colors.black : Colors.white,
              activeColor: tPrimaryColor,
              activeTrackColor: tPrimaryColor.shade100,
              dense: false,
              controlAffinity: ListTileControlAffinity.trailing,
              contentPadding:
                  const EdgeInsetsDirectional.fromSTEB(24, 12, 24, 12),
            ),
          ),
          Obx(
            () => SwitchListTile.adaptive(
              value: _controller.switchListTileValue3.value,
              onChanged: (value) =>
                  _controller.switchListTileValue3.value = value,
              title: Text('Location Services',
                  style: Theme.of(context).textTheme.titleMedium),
              subtitle: Text(
                  'Allow us to track your location, this helps keep track of spending and keeps you safe.',
                  style: Theme.of(context).textTheme.titleSmall),
              tileColor: isDark ? Colors.black : Colors.white,
              activeColor: tPrimaryColor,
              activeTrackColor: tPrimaryColor.shade100,
              dense: false,
              controlAffinity: ListTileControlAffinity.trailing,
              contentPadding:
                  const EdgeInsetsDirectional.fromSTEB(24, 12, 24, 12),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
            child: SizedBox(
              width: 190,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  userDataBox!.put('push_notifications', pushNotifications);
                  userDataBox!.put('email_notifications', emailNotifications);
                },
                style: ButtonStyle(
                  padding: const MaterialStatePropertyAll(
                      EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0)),
                  backgroundColor: MaterialStatePropertyAll(
                      isDark ? tPrimaryColor : tPrimaryColor.shade300),
                  elevation: const MaterialStatePropertyAll(3),
                ),
                child: Text(
                  'Save Changes',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
