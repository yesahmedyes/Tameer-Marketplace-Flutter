import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tameer/logic/login/login_bloc.dart';
import 'package:tameer/logic/signup/signup_bloc.dart';
import 'package:tameer/presentation/screens/home/homeScreen.dart';
import 'package:tameer/presentation/screens/login/gettingStarted.dart';
import 'package:tameer/presentation/screens/signup/signupScreen.dart';
import 'package:tameer/presentation/splash.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        Navigator.of(context).popUntil(ModalRoute.withName(Navigator.defaultRouteName));
      },
      listenWhen: (previous, current) => (previous is! LoginSuccessState && current is LoginSuccessState) || (previous is! LoginInitialState && current is LoginInitialState),
      buildWhen: (previous, current) => (previous is! LoginSuccessState && current is LoginSuccessState) || (previous is! LoginInitialState && current is LoginInitialState),
      builder: (context, state) {
        if (state is LoginCheckingStatusState) return const SplashScreen();
        if (state is LoginSuccessState) {
          context.read<SignupBloc>().add(SignupCheckStatusEvent());
          return BlocConsumer<SignupBloc, SignupState>(
            listener: (context, state) {
              Navigator.of(context).popUntil(ModalRoute.withName(Navigator.defaultRouteName));
            },
            listenWhen: (previous, current) => (previous is! SignupSuccessState && current is SignupSuccessState),
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) {
              if (state is SignupCheckingStatusState) return const SplashScreen();
              if (state is SignupSuccessState) {
                return HomeScreen();
              }
              return const SignupScreen();
            },
          );
        }
        return const GettingStartedScreen();
      },
    );
  }
}
