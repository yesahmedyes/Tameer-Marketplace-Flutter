import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tameer/logic/profile/profile_bloc.dart';
import 'package:tameer/presentation/screens/profile/widgets/profileForm.dart';
import 'package:tameer/presentation/widgets/appBars/customAppBarBack.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBarBack(
        text: 'Profile',
        onPressed: () {
          context.read<ProfileBloc>().add(ProfileFormCloseEvent());
          Navigator.of(context).pop();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.06),
              const ProfileForm(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.06),
            ],
          ),
        ),
      ),
    );
  }
}
