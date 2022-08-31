import 'package:flutter/material.dart';
import 'package:tameer/presentation/widgets/misc/customProgressIndicator.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(bottom: 50.0),
        child: CustomProgressIndicator(),
      ),
    );
  }
}
