import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tameer/logic/cart/cart_bloc.dart';
import 'package:tameer/presentation/widgets/buttons/fullWidthButton.dart';

class CustomBottomNavigation extends StatelessWidget {
  final String? text;
  final VoidCallback? onPressed;

  const CustomBottomNavigation({Key? key, required this.text, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 2, offset: const Offset(0, -2)),
        ],
      ),
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartOpenedState && state.items.isNotEmpty) {
            final int totalPrice = state.items.map(((e) => e.price * e.quantity)).sum;
            final int totalItems = state.items.length;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Total Items", style: Theme.of(context).textTheme.headline2!.copyWith(fontWeight: FontWeight.w500)),
                            Text("Total Price", style: Theme.of(context).textTheme.headline2!.copyWith(fontWeight: FontWeight.w500)),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("$totalItems", style: Theme.of(context).textTheme.headline2),
                            Text("Rs $totalPrice", style: Theme.of(context).textTheme.headline2),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  FullWidthButton(text: text, onPressed: onPressed),
                  const SizedBox(height: 10),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
