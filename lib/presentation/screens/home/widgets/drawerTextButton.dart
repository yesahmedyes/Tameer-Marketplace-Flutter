import 'package:flutter/material.dart';

class DrawerTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;

  const DrawerTextButton({Key? key, required this.text, required this.onPressed, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: (icon == null)
          ? Text(text, style: Theme.of(context).textTheme.subtitle1)
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.black87),
                const SizedBox(width: 8),
                Text(text, style: Theme.of(context).textTheme.subtitle1!.copyWith(height: 1.25)),
              ],
            ),
      style: TextButton.styleFrom(padding: const EdgeInsets.all(15)),
    );
  }
}
