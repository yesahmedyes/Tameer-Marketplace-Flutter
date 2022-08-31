import 'package:flutter/material.dart';
import 'package:tameer/presentation/decorations/images.dart';
import 'package:tameer/presentation/widgets/buttons/fullWidthButton.dart';

class GettingStartedScreen extends StatelessWidget {
  const GettingStartedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Image.asset(
            gettingStartedImage,
            color: const Color.fromRGBO(255, 255, 255, 0.5),
            colorBlendMode: BlendMode.modulate,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: MediaQuery.of(context).size.height * 0.125),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 25),
                      Text(
                        'One stop shop for all your construction material needs',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ],
                  ),
                  FullWidthButton(onPressed: () => Navigator.pushNamed(context, '/login'), text: 'Get Started'),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
