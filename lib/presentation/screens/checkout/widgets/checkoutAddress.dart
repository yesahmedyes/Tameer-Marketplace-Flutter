import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tameer/logic/checkout/checkout_bloc.dart';

class CheckoutAddress extends StatelessWidget {
  const CheckoutAddress({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Address', style: Theme.of(context).textTheme.subtitle1),
            IconButton(icon: const Icon(Icons.edit, color: Colors.grey, size: 20), onPressed: () => Navigator.of(context).popUntil(ModalRoute.withName('/location'))),
          ],
        ),
        const SizedBox(height: 12),
        BlocBuilder<CheckoutBloc, CheckoutState>(
          buildWhen: (previous, current) => current is CheckoutOpenedState,
          builder: (context, state) {
            return Text(
              (state is CheckoutOpenedState && state.address.isNotEmpty) ? state.address : 'No address added.',
              style: Theme.of(context).textTheme.bodyText1,
            );
          },
        ),
      ],
    );
  }
}
