import 'package:flutter/material.dart';

Future<void> showCustomModal(
  BuildContext context, {
  required Widget child,
}) {
  return showDialog(context: context, barrierDismissible: true, builder: (context) => child);
}
