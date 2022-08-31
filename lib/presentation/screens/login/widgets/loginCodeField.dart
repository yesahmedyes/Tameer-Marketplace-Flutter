import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:tameer/logic/login/login_bloc.dart';
import 'package:tameer/presentation/widgets/formComponents/customTextFormField.dart';

class LoginCodeField extends StatelessWidget {
  const LoginCodeField({Key? key, required TextEditingController codeController})
      : _codeController = codeController,
        super(key: key);

  final TextEditingController _codeController;

  String? codeValidation(String? text) {
    if (text == null || text.isEmpty) {
      return "Please enter the code";
    }
    if (text.length != 6) {
      return "Must be 6 digits in length";
    }
    if (int.tryParse(text) == null) {
      return "Must be not contain letters or symbols";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) {
        if (previous is! LoginOtpWaitingState && current is LoginOtpWaitingState || previous is! LoginOtpVerifyingState && current is LoginOtpVerifyingState) {
          return true;
        }
        if (previous is LoginOtpWaitingState && current is! LoginOtpWaitingState || previous is LoginOtpVerifyingState && current is! LoginOtpVerifyingState) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        if (state is LoginOtpWaitingState || state is LoginOtpVerifyingState) {
          int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60;
          return Column(
            children: [
              const SizedBox(height: 30),
              CustomTextFormField(
                controller: _codeController,
                enabled: (state is LoginOtpWaitingState) ? true : false,
                text: 'Code',
                keyboardType: TextInputType.number,
                validator: codeValidation,
              ),
              const SizedBox(height: 30),
              CountdownTimer(
                endTime: endTime,
                widgetBuilder: (_, time) => (time == null)
                    ? TextButton(onPressed: () => context.read<LoginBloc>().add(LoginForceRedemandOtpEvent()), child: const Text('Resend token'))
                    : Text(
                        "Resend code in: 0:" + time.sec.toString(),
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
              )
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
