import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tameer/data/models/profile.dart';
import 'package:tameer/logic/login/login_bloc.dart';
import 'package:tameer/logic/profile/profile_bloc.dart';
import 'package:tameer/logic/signup/signup_bloc.dart';
import 'package:tameer/presentation/screens/profile/widgets/emailField.dart';
import 'package:tameer/presentation/screens/profile/widgets/idField.dart';
import 'package:tameer/presentation/screens/profile/widgets/nameField.dart';
import 'package:tameer/presentation/screens/profile/widgets/phoneField.dart';
import 'package:tameer/presentation/widgets/buttons/fullWidthButton.dart';
import 'package:tameer/presentation/widgets/misc/customDialog.dart';
import 'package:tameer/presentation/widgets/formComponents/customDropDown.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({Key? key}) : super(key: key);

  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _id = TextEditingController();

  String? _initial;

  final _form = GlobalKey<FormState>();

  void _submitForm() {
    final isValid = _form.currentState!.validate();
    if (isValid) {
      Map<String, dynamic> _map = {};

      final ProfileFormOpenState state = context.read<ProfileBloc>().state as ProfileFormOpenState;

      _map['type'] = state.type;
      _map['name'] = _name.text;
      _map['phoneNumber'] = _phoneNumber.text;
      _map['email'] = _email.text;
      _map['idNumber'] = _id.text;

      context.read<ProfileBloc>().add(ProfileUploadEvent(_map));
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final ProfileState profileState = context.read<ProfileBloc>().state;

    if (profileState is ProfileInitialState) {
      final SignupState signupState = context.read<SignupBloc>().state;

      if (signupState is SignupSuccessState) {
        final Profile profile = signupState.profile;

        _name.text = profile.name;
        _phoneNumber.text = profile.phoneNumber;
        _email.text = profile.emailAddress ?? '';
        _id.text = profile.idNumber ?? '';
        _initial = profile.type;
      }

      if (_phoneNumber.text.isEmpty) {
        final LoginState loginState = context.read<LoginBloc>().state;

        if (loginState is LoginSuccessState) _phoneNumber.text = loginState.firebaseUser!.phoneNumber!;
      }

      context.read<ProfileBloc>().add(ProfileFormOpenEvent());
    }
  }

  void _typeChanged(String type, BuildContext context) {
    context.read<ProfileBloc>().add(ProfileTypeChangeEvent(type: type));
  }

  @override
  void deactivate() {
    context.read<ProfileBloc>().add(ProfileFormCloseEvent());
    super.deactivate();
  }

  @override
  void dispose() {
    _name.dispose();
    _phoneNumber.dispose();
    _email.dispose();
    _id.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileUploadFailedState) {
          customDialog(
            context: context,
            text: state.error,
            actionText: 'Ok',
            action: () {
              context.read<ProfileBloc>().add(ProfileFormOpenEvent());
            },
          );
        }
        if (state is ProfileUploadSuccessState) {
          if (Navigator.of(context).canPop()) Navigator.of(context).pop();
        }
      },
      child: Form(
        key: _form,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: CustomDropDown(
                options: const ['Individual', 'Company'],
                optionalFunction: _typeChanged,
                initial: _initial,
              ),
            ),
            NameField(name: _name),
            PhoneField(phoneNumber: _phoneNumber),
            EmailField(email: _email),
            IdField(id: _id),
            const SizedBox(height: 25),
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                return FullWidthButton(text: (state is ProfileUploadingState) ? null : 'Submit', onPressed: () => _submitForm());
              },
            ),
          ],
        ),
      ),
    );
  }
}
