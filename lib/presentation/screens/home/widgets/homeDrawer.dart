import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tameer/logic/login/login_bloc.dart';
import 'package:tameer/logic/signup/signup_bloc.dart';
import 'package:tameer/presentation/screens/home/widgets/drawerTextButton.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.055),
              BlocBuilder<SignupBloc, SignupState>(
                builder: (context, state) {
                  if (state is SignupSuccessState) {
                    return SizedBox(child: Text(state.profile.name, style: Theme.of(context).textTheme.headline1, textAlign: TextAlign.center), width: double.infinity);
                  }
                  return const SizedBox.shrink();
                },
                buildWhen: (previous, current) => previous != current && current is SignupSuccessState,
              ),
              const SizedBox(height: 50),
              Container(color: Colors.black12, width: double.infinity, height: 1),
              const SizedBox(height: 25),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DrawerTextButton(text: 'Profile', onPressed: () => Navigator.of(context).pushNamed('/profile'), icon: Icons.person_outline),
                  DrawerTextButton(text: 'Orders', onPressed: () {}, icon: Icons.assignment_outlined),
                  // DrawerTextButton(text: 'Payment methods', onPressed: () {}, icon: Icons.local_atm_outlined),
                  // DrawerTextButton(text: 'Addresses', onPressed: () {}, icon: Icons.location_on_outlined),
                ],
              ),
              const SizedBox(height: 25),
              Container(color: Colors.black12, width: double.infinity, height: 1),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DrawerTextButton(text: 'Terms & Conditions', onPressed: () {}),
                  DrawerTextButton(
                    text: 'Log out',
                    onPressed: () {
                      context.read<LoginBloc>().add(LoginLogoutEvent());
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
