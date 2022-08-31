import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tameer/data/models/cartItem.dart';

class CartItemTile extends StatefulWidget {
  final CartItem item;

  const CartItemTile({Key? key, required this.item}) : super(key: key);

  @override
  State<CartItemTile> createState() => _CartItemTileState();
}

class _CartItemTileState extends State<CartItemTile> {
  bool opened = false;

  void _changeState() {
    setState(() {
      opened = !opened;
    });
  }

  @override
  Widget build(BuildContext context) {
    final int totalPrice = widget.item.quantity * widget.item.price;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.white,
      elevation: 1,
      child: InkWell(
        onTap: _changeState,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              child: Row(
                children: [
                  CachedNetworkImage(imageUrl: widget.item.productImage, width: 70, height: 70),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (opened) ? widget.item.productName : '${widget.item.productName} (${widget.item.quantity})',
                          style: Theme.of(context).textTheme.headline2!.copyWith(fontWeight: FontWeight.w600, height: 1.4),
                          maxLines: 2,
                        ),
                        const SizedBox(height: 10),
                        if (!opened) Text('Rs $totalPrice'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: opened ? const Icon(Icons.keyboard_arrow_up) : const Icon(Icons.keyboard_arrow_down),
                  ),
                ],
              ),
            ),
            if (opened) Container(color: Colors.grey.withOpacity(0.1), width: double.infinity, height: 1),
            if (opened)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Item Price", style: Theme.of(context).textTheme.subtitle1),
                            const SizedBox(height: 4),
                            Text("Quantity", style: Theme.of(context).textTheme.subtitle1),
                            const SizedBox(height: 4),
                            Text("Total Price", style: Theme.of(context).textTheme.subtitle1),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Rs ${widget.item.price}", style: Theme.of(context).textTheme.bodyText1),
                            const SizedBox(height: 4),
                            Text("${widget.item.quantity}", style: Theme.of(context).textTheme.bodyText1),
                            const SizedBox(height: 4),
                            Text("Rs $totalPrice", style: Theme.of(context).textTheme.bodyText1),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
