import 'package:flutter/material.dart';
import 'package:tameer/presentation/widgets/formComponents/customTextFormField.dart';

class PhoneField extends StatelessWidget {
  const PhoneField({
    Key? key,
    required TextEditingController phoneNumber,
  })  : _phoneNumber = phoneNumber,
        super(key: key);

  final TextEditingController _phoneNumber;

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
    return CustomTextFormField(
      controller: _phoneNumber,
      text: 'Phone number',
      padding: 12,
      keyboardType: TextInputType.phone,
      validator: phoneValidation,
    );
  }
}
