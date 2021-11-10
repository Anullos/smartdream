import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartdream/core/shared/presentation/blocs/cart/cart_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartdream/core/shared/presentation/blocs/cart/cart_state.dart';
import 'package:smartdream/features/order/domain/repository/order_repository_interface.dart';
import 'package:smartdream/features/order/presentation/blocs/order_cubit.dart';
import 'package:smartdream/features/order/presentation/blocs/order_state.dart';
import 'package:smartdream/features/order/presentation/widgets/animate_order_success.dart';
import 'package:smartdream/features/order/presentation/widgets/item_cart.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.read<CartCubit>();
    final stringProductos =
        (cartCubit.cartList.length <= 1) ? 'Total product' : 'Total products';

    return BlocProvider(
      create: (_) => OrderCubit(
        orderRepositoryInterface: context.read<OrderRepositoryInterface>(),
      ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Order'),
          backgroundColor: Colors.green,
        ),
        backgroundColor: Colors.green.shade100,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 24.0, right: 24.0, top: 20.0, bottom: 100.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Your products section
                    const Text(
                      'Your products',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<CartCubit, CartState>(
                      builder: (context, state) {
                        return cartCubit.cartList.isEmpty
                            ? const Card(
                                elevation: 5,
                                child: SizedBox(
                                  height: 100,
                                  child: Center(
                                    child: Text(
                                      'No products',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Flexible(
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: cartCubit.cartList.length,
                                  itemBuilder: (context, index) {
                                    final cartProduct =
                                        cartCubit.cartList[index];
                                    return ItemCart(cartProduct: cartProduct);
                                  },
                                ),
                              );
                      },
                    ),
                    const SizedBox(height: 20),
                    // Resumen section
                    const Text(
                      'Resumen',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Card(
                      elevation: 5,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  stringProductos,
                                  style: const TextStyle(fontSize: 18),
                                ),
                                BlocBuilder<CartCubit, CartState>(
                                  builder: (context, state) {
                                    return Text(
                                      '${cartCubit.cartList.length}',
                                      style: const TextStyle(fontSize: 18),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Total to pay',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                BlocBuilder<CartCubit, CartState>(
                                  builder: (context, state) {
                                    double total = 0;
                                    for (final cartProduct
                                        in cartCubit.cartList) {
                                      total +=
                                          cartProduct.product.currentPrice *
                                              cartProduct.quantity;
                                    }
                                    return Text(
                                      '\$${total.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Background success
            BlocConsumer<OrderCubit, OrderState>(
              listener: (context, state) {
                if (state is OrderFailure) {
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
              builder: (context, state) {
                final isSuccess = state is OrderSuccess;
                return isSuccess
                    ? Positioned(
                        child: Container(
                          color: Colors.black26,
                        ),
                      )
                    : Container();
              },
            ),
            BlocConsumer<CartCubit, CartState>(
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
              builder: (context, state) {
                return Container();
              },
            ),
            // Animated Success
            const AnimateOrderSuccess(),
          ],
        ),
      ),
    );
  }
}
