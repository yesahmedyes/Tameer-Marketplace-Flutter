import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tameer/logic/cart/cart_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CheckoutCart extends StatelessWidget {
  const CheckoutCart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartOpenedState && state.items.isNotEmpty) {
          final items = state.items;
          return ListView.builder(
            itemCount: items.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final price = items[index].price * items[index].quantity;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CachedNetworkImage(imageUrl: items[index].productImage, width: 80, height: 80),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(items[index].productName, style: Theme.of(context).textTheme.subtitle1),
                          Text('Quantity: ${items[index].quantity}', style: Theme.of(context).textTheme.bodyText1),
                          Text('Rs $price', style: Theme.of(context).textTheme.bodyText1),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
        return Row(
          children: [
            Text('No items in cart.', style: Theme.of(context).textTheme.bodyText1),
          ],
        );
      },
    );
  }
}
