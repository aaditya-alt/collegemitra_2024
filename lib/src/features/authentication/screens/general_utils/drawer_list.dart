import 'package:flutter/material.dart';

class DrawerList extends StatelessWidget {
  const DrawerList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Dashboard", Icons.dashboard_outlined, false, context),
          menuItem(2, "Contacts", Icons.people_alt_outlined, false, context),
          menuItem(3, "Events", Icons.event, false, context),
          menuItem(4, "Notes", Icons.notes, false, context),
          const Divider(),
          menuItem(5, "Settings", Icons.settings_outlined, false, context),
          menuItem(
              6, "Notifications", Icons.notifications_outlined, false, context),
          const Divider(),
          menuItem(
              7, "Privacy policy", Icons.privacy_tip_outlined, false, context),
          menuItem(8, "Send feedback", Icons.feedback_outlined, false, context),
        ],
      ),
    );
  }
}

Widget menuItem(
    int id, String title, IconData icon, bool selected, BuildContext context) {
  return Material(
    color: selected ? Colors.grey[300] : Colors.transparent,
    child: InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Expanded(
              child: Icon(
                icon,
                size: 20,
                color: Colors.black,
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
