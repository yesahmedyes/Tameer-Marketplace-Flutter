import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tameer/logic/login/login_bloc.dart';
import 'package:tameer/presentation/decorations/wavesA.dart';
import 'package:tameer/presentation/screens/login/widgets/loginCodeField.dart';
import 'package:tameer/presentation/screens/login/widgets/loginPhoneField.dart';
import 'package:tameer/presentation/widgets/buttons/fullWidthButton.dart';
import 'package:tameer/presentation/widgets/misc/customDialog.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController _phoneController = TextEditingController(text: '+92 ');
  final TextEditingController _codeController = TextEditingController();

  final _phoneForm = GlobalKey<FormState>();
  final _codeForm = GlobalKey<FormState>();

  void _submitPhoneNumber(BuildContext context) {
    final isValid = _phoneForm.currentState!.validate();

    if (isValid) {
      final phoneNumber = _phoneController.text;
      context.read<LoginBloc>().add(LoginSendPhoneEvent(phoneNumber: phoneNumber));
    }
  }

  void _submitCode(BuildContext context) {
    final isValid = _codeForm.currentState!.validate();

    if (isValid) {
      final otp = _codeController.text;
      context.read<LoginBloc>().add(LoginSendOtpEvent(otp: otp));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        painter: WavesA(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: BlocListener<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LoginFailedState) {
                      customDialog(
                        context: context,
                        text: state.error,
                        actionText: 'Ok',
                        action: () {
                          _phoneController.text = "+92 ";
                          _codeController.clear();
                          context.read<LoginBloc>().add(LoginSetToInitialEvent());
                          Navigator.of(context).pop();
                        },
                      );
                    }
                  },
                  listenWhen: (previous, current) => previous is! LoginFailedState && current is LoginFailedState,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Let's Get Started", style: Theme.of(context).textTheme.headline1),
                      const SizedBox(height: 8),
                      Text('App use karny kayliyay pehly apna phone number verify karain', style: Theme.of(context).textTheme.bodyText1),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                      Form(key: _phoneForm, child: LoginPhoneField(phoneController: _phoneController)),
                      Form(key: _codeForm, child: LoginCodeField(codeController: _codeController)),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.045),
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          return FullWidthButton(
                            onPressed: (state is LoginOtpWaitingState) ? () => _submitCode(context) : () => _submitPhoneNumber(context),
                            text: (state is LoginOtpVerifyingState || state is LoginPhoneSentState) ? null : ((state is LoginOtpWaitingState) ? 'Submit code' : 'Get code'),
                          );
                        },
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
