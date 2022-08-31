import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tameer/logic/checkout/checkout_bloc.dart';

class AddressTextField extends StatefulWidget {
  const AddressTextField({Key? key}) : super(key: key);

  @override
  State<AddressTextField> createState() => _AddressTextFieldState();
}

class _AddressTextFieldState extends State<AddressTextField> {
  final TextEditingController controller = TextEditingController();

  @override
  void didChangeDependencies() {
    final CheckoutState state = context.read<CheckoutBloc>().state;
    if (state is CheckoutOpenedState) {
      controller.text = state.address;
    }
    super.didChangeDependencies();
  }

  String? addressValidation(String? text) {
    if (text == null || text.isEmpty) {
      return "Please enter an address";
    }
    if (text.length < 10) {
      return "Must be a full address";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      minLines: 2,
      maxLines: 5,
      validator: addressValidation,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.all(20),
        labelText: 'Address',
      ),
      onChanged: (String text) {
        context.read<CheckoutBloc>().add(CheckoutChangeEvent(address: text));
      },
    );
  }
}
