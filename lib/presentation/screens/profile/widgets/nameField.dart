import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tameer/logic/profile/profile_bloc.dart';
import 'package:tameer/presentation/widgets/formComponents/customTextFormField.dart';

class NameField extends StatelessWidget {
  const NameField({
    Key? key,
    required TextEditingController name,
  })  : _name = name,
        super(key: key);

  final TextEditingController _name;

  String? nameValidation(String? text) {
    if (text == null || text.isEmpty) {
      return "Please enter a name";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) => current is ProfileFormOpenState && previous != current,
      builder: (context, state) {
        return CustomTextFormField(
          controller: _name,
          text: (state is ProfileFormOpenState && state.type == 'Company') ? 'Company name' : 'Full Name',
          padding: 12,
          validator: nameValidation,
        );
      },
    );
  }
}
