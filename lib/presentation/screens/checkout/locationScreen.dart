import 'package:flutter/material.dart';
import 'package:tameer/presentation/screens/checkout/widgets/addressTextField.dart';
import 'package:tameer/presentation/widgets/appBars/customAppBarBack.dart';
import 'package:tameer/presentation/widgets/buttons/fullWidthButton.dart';

class LocationScreen extends StatelessWidget {
  LocationScreen({Key? key}) : super(key: key);

  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarBack(text: 'Checkout'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.065),
            Text('ENTER ADDRESS', style: Theme.of(context).textTheme.headline1),
            const SizedBox(height: 12),
            Text('Order place karny kay liyay apna address enter karain', style: Theme.of(context).textTheme.bodyText1),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Form(
              key: _form,
              child: const AddressTextField(),
            ),
            const SizedBox(height: 25),
            FullWidthButton(
              text: 'Proceed',
              onPressed: () {
                final isValid = _form.currentState!.validate();
                if (isValid) {
                  FocusManager.instance.primaryFocus?.unfocus();
                  Navigator.of(context).pushNamed('/checkout');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
