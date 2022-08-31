import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final bool enabled;
  final double? padding;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.text,
    this.padding,
    this.validator,
    this.enabled = true,
    this.keyboardType = TextInputType.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: (padding != null) ? EdgeInsets.symmetric(vertical: padding!) : EdgeInsets.zero,
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: const EdgeInsets.all(20),
          labelText: text,
        ),
      ),
    );
  }
}
