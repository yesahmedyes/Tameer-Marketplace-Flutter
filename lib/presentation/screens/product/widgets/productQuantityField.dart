import 'package:flutter/material.dart';

class ProductQuantityField extends StatelessWidget {
  ProductQuantityField({
    Key? key,
  }) : super(key: key);

  final TextEditingController _quantityController = TextEditingController(text: "0");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          TextButton(
            onPressed: () {},
            child: const Icon(Icons.remove, color: Colors.grey),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(16),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.horizontal(left: Radius.circular(10)),
                side: BorderSide(color: Colors.grey),
              ),
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: _quantityController,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline1!.copyWith(height: 1.5),
              decoration: const InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide()),
                contentPadding: EdgeInsets.all(14.5),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Icon(Icons.add, color: Colors.grey),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(16),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.horizontal(right: Radius.circular(10)),
                side: BorderSide(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
