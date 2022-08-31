import 'package:flutter/material.dart';

class FullWidthButton extends StatelessWidget {
  final String? text;
  final VoidCallback? onPressed;
  final bool? primary;

  const FullWidthButton({Key? key, this.onPressed, this.text, this.primary = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: (text == null) ? null : onPressed,
        style: TextButton.styleFrom(
          backgroundColor: (primary == false) ? Colors.transparent : Theme.of(context).primaryColor,
          padding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: BorderSide(color: Theme.of(context).primaryColor)),
          textStyle: const TextStyle(fontSize: 17),
        ),
        child: (text == null)
            ? SizedBox(
                child: CircularProgressIndicator(color: (primary == false) ? Theme.of(context).primaryColor : Colors.white, strokeWidth: 2),
                height: 20,
                width: 20,
              )
            : Text(text!, style: TextStyle(color: (primary == false) ? Theme.of(context).primaryColor : Colors.white)),
      ),
    );
  }
}
