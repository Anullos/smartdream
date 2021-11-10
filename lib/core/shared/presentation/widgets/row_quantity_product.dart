import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RowQuantityProduct extends StatelessWidget {
  final VoidCallback onTapDecrement;
  final VoidCallback onTapIncrement;
  final int quantity;
  const RowQuantityProduct(
      {Key? key,
      required this.onTapDecrement,
      required this.onTapIncrement,
      required this.quantity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CupertinoButton(
            padding: const EdgeInsets.all(0),
            child: const Icon(
              Icons.remove,
              color: Colors.red,
            ),
            onPressed: onTapDecrement,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: RichText(
              softWrap: true,
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Amount: ',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: quantity.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          CupertinoButton(
            padding: const EdgeInsets.all(0),
            child: const Icon(Icons.add),
            onPressed: onTapIncrement,
          ),
        ],
      ),
    );
  }
}
