import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tameer/logic/login/login_bloc.dart';
import 'package:tameer/presentation/widgets/formComponents/customTextFormField.dart';

class LoginPhoneField extends StatelessWidget {
  const LoginPhoneField({
    Key? key,
    required TextEditingController phoneController,
  })  : _phoneController = phoneController,
        super(key: key);

  final TextEditingController _phoneController;

  String? phoneValidation(String? text) {
    if (text == null || text.isEmpty) {
      return "Please enter a phone number";
    }
    if (text.length != 13 && text.length != 14) {
      return "Must be correct format: +92 XXXXXXXXXX";
    }
    if (text.substring(0, 3) != "+92") {
      return "Must be correct format: +92 XXXXXXXXXX";
    }
    if (int.tryParse(text.substring(1).replaceAll(' ', '')) == null) {
      return "Must be not contain letters or symbols";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) {
        return ((previous is! LoginInitialState && current is LoginInitialState) || (previous is LoginInitialState && current is! LoginInitialState));
      },
      builder: (context, state) {
        return CustomTextFormField(
          controller: _phoneController,
          text: 'Phone Number',
          enabled: (state is LoginInitialState) ? true : false,
          keyboardType: TextInputType.phone,
          validator: phoneValidation,
        );
      },
    );
  }
}
