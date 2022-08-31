import 'package:flutter/material.dart';
import 'package:tameer/presentation/widgets/formComponents/customTextFormField.dart';

class EmailField extends StatelessWidget {
  const EmailField({
    Key? key,
    required TextEditingController email,
  })  : _email = email,
        super(key: key);

  final TextEditingController _email;

  String? emailValidation(String? text) {
    if (text != null && text.isNotEmpty) {
      if (!RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(text)) {
        return "Must be a correct email address";
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: _email,
      text: 'Email address (optional)',
      padding: 12,
      keyboardType: TextInputType.emailAddress,
      validator: emailValidation,
    );
  }
}
