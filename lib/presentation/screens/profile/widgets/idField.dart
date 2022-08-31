import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tameer/logic/profile/profile_bloc.dart';
import 'package:tameer/presentation/widgets/formComponents/customTextFormField.dart';

class IdField extends StatelessWidget {
  const IdField({
    Key? key,
    required TextEditingController id,
  })  : _id = id,
        super(key: key);

  final TextEditingController _id;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) => current is ProfileFormOpenState && previous != current,
      builder: (context, state) {
        final String val = (state is ProfileFormOpenState && state.type == 'Company') ? "NTN number" : "CNIC number";

        return CustomTextFormField(controller: _id, text: '$val (optional)', padding: 12, keyboardType: TextInputType.emailAddress);
      },
    );
  }
}
