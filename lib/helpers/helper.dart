import 'package:flutter/material.dart';

Future<void> showAlertDialog(bool isVisible, BuildContext context) async {
  if (isVisible) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // prevent dismissing by tapping outside
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text("Summarizing..."),
            ],
          ),
        );
      },
    );
  } else {
    Navigator.of(context).pop(); // close the AlertDialog
  }
}