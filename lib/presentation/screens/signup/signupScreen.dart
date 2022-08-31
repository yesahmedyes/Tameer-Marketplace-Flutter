import 'package:flutter/material.dart';
import 'package:tameer/presentation/screens/profile/widgets/profileForm.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('SIGN UP', style: Theme.of(context).textTheme.headline1),
                const SizedBox(height: 12),
                Text('Service istemal karny say pehlay please sign up karain', style: Theme.of(context).textTheme.bodyText1),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                const ProfileForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
