import 'dart:ui';

import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

void showWait(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Container(
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: CircularProgressIndicator()),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: const Text(
                        "LOADING...",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ));
      });
}
