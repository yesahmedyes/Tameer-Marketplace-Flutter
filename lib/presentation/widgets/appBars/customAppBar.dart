import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tameer/logic/cart/cart_bloc.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      iconTheme: const IconThemeData(color: Colors.black54),
      actionsIconTheme: const IconThemeData(color: Colors.black54),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/cart');
            },
            icon: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if (state is CartOpenedState && state.items.isNotEmpty) {
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const Icon(Icons.shopping_cart_rounded),
                      Positioned(
                        top: -4,
                        right: -4,
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).primaryColor),
                          child: Center(child: Text(state.items.length.toString(), style: const TextStyle(fontSize: 8, color: Colors.white))),
                        ),
                      )
                    ],
                  );
                }
                return const Icon(Icons.shopping_cart_rounded);
              },
            ),
          ),
        ),
      ],
      title: Text('Tameer', style: Theme.of(context).textTheme.headline1!.copyWith(height: 1.6)),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
