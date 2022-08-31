import 'package:flutter/material.dart';

Future<void> customDialog({required BuildContext context, required String text, required String actionText, required VoidCallback action}) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Text(text, style: Theme.of(context).textTheme.bodyText1),
        actions: <Widget>[
          TextButton(onPressed: action, child: Text(actionText)),
        ],
      );
    },
  );
}
