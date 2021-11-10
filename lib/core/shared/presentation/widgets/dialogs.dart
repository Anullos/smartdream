import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartdream/core/shared/presentation/blocs/cart/cart_state.dart';
import 'package:smartdream/core/shared/presentation/widgets/row_quantity_product.dart';
import 'package:smartdream/core/utils/functions.dart';
import 'package:smartdream/features/product/domain/models/product_model.dart';
import 'package:smartdream/core/shared/presentation/blocs/cart/cart_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectionProductAlertDialog extends StatefulWidget {
  final ProductModel product;
  const SelectionProductAlertDialog({Key? key, required this.product})
      : super(key: key);

  @override
  _SelectionProductAlertDialogState createState() =>
      _SelectionProductAlertDialogState();
}

class _SelectionProductAlertDialogState
    extends State<SelectionProductAlertDialog> {
  int quantity = 1;

  // Update the quantity value
  void _updateQuantity(int numero) {
    if ((quantity < 9 && numero > 0) || (quantity > 1 && numero < 0)) {
      setState(() {
        quantity += numero;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.read<CartCubit>();
    return BlocListener<CartCubit, CartState>(
      listener: (context, state) {
        if (state is CartFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.error,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.red,
              duration: const Duration(milliseconds: 1800),
            ),
          );
        }
      },
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        title: Column(
          children: [
            Image.asset(
              widget.product.image,
              fit: BoxFit.cover,
              width: 200,
              height: 160,
            ),
          ],
        ),
        contentPadding: const EdgeInsets.all(0),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Name of the product
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
              child: Text(
                widget.product.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
            // Quantity of the product
            RowQuantityProduct(
              onTapDecrement: () => _updateQuantity(-1),
              onTapIncrement: () => _updateQuantity(1),
              quantity: quantity,
            ),
            const SizedBox(height: 18.0),
            // Text Price
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    resumePrice(widget.product.currentPrice, quantity),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            //Bottons Cancelar y Aceptar
            const SizedBox(height: 18.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    final result =
                        await cartCubit.addCart(widget.product, quantity);
                    if (result == true) {
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    'Aceptar',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }
}
