import 'package:flutter/material.dart';
import 'package:tameer/data/models/product.dart';
import 'package:tameer/extensions.dart';

class ProductDetailPrice extends StatelessWidget {
  const ProductDetailPrice({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    if (product.retailPrice > product.price) {
      double percentage = (1 - product.price / product.retailPrice) * 100;
      percentage = percentage.toPrecision(1);

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('Rs ${product.price}', style: Theme.of(context).textTheme.headline2!.copyWith(height: 1), textAlign: TextAlign.center),
          const SizedBox(width: 4),
          Text('${product.retailPrice}', style: Theme.of(context).textTheme.headline4!.copyWith(decoration: TextDecoration.lineThrough), textAlign: TextAlign.center),
          const SizedBox(width: 6),
          Text(
            '($percentage% less)',
            style: Theme.of(context).textTheme.headline4!.copyWith(color: Theme.of(context).primaryColor, height: 2),
          )
        ],
      );
    } else {
      return Text('Rs ${product.price}', style: Theme.of(context).textTheme.headline2!.copyWith(height: 1), textAlign: TextAlign.center);
    }
  }
}
