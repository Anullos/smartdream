import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartdream/core/shared/presentation/widgets/row_quantity_product.dart';
import 'package:smartdream/core/utils/functions.dart';
import 'package:smartdream/features/cart/domain/models/cart_model.dart';
import 'package:smartdream/core/shared/presentation/blocs/cart/cart_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemCart extends StatelessWidget {
  final CartModel cartProduct;
  const ItemCart({Key? key, required this.cartProduct}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cartCubit = context.read<CartCubit>();
    return SizedBox(
      // height: 120,
      child: Card(
        elevation: 5,
        child: Column(
          children: [
            Row(
              children: [
                // Imagen del cart
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    cartProduct.product.image,
                    width: size.width * 0.24,
                  ),
                ),
                Column(
                  children: [
                    // Texto del cart
                    Padding(
                      padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: size.width * 0.38,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  cartProduct.product.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 3.0),
                                Text(
                                  resumePrice(cartProduct.product.currentPrice,
                                      cartProduct.quantity),
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          CupertinoButton(
                            padding: const EdgeInsets.all(0.0),
                            onPressed: () => cartCubit.removeCart(cartProduct),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.grey,
                              size: 35,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // Cantidad del cart
            RowQuantityProduct(
              onTapDecrement: () async => await cartCubit.updateCart(
                  cartProduct, cartProduct.quantity - 1),
              onTapIncrement: () async => await cartCubit.updateCart(
                  cartProduct, cartProduct.quantity + 1),
              quantity: cartProduct.quantity,
            ),
          ],
        ),
      ),
    );
  }
}
