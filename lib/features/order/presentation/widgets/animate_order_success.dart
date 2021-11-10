import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartdream/core/shared/presentation/blocs/cart/cart_cubit.dart';
import 'package:smartdream/core/shared/presentation/blocs/cart/cart_state.dart';
import 'package:smartdream/core/shared/presentation/widgets/delayed_display.dart';
import 'package:smartdream/features/order/presentation/blocs/order_cubit.dart';
import 'package:smartdream/features/order/presentation/blocs/order_state.dart';

class AnimateOrderSuccess extends StatelessWidget {
  const AnimateOrderSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, stateOrder) {
        final orderCubit = context.read<OrderCubit>();
        final isLoading = stateOrder is OrderLoading;
        final isSuccess = stateOrder is OrderSuccess;
        final size = MediaQuery.of(context).size;
        return AnimatedPositioned(
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOut,
          bottom: isSuccess ? size.height * 0.3 : 0.0,
          left: 0,
          right: 0,
          child: Padding(
            padding: isSuccess
                ? const EdgeInsets.symmetric(horizontal: 60.0, vertical: 24.0)
                : const EdgeInsets.symmetric(horizontal: 0.0, vertical: 24.0),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 800),
              height: isSuccess ? 200 : 50,
              decoration: BoxDecoration(
                color: isSuccess ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: isSuccess
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Flexible(
                          child: Icon(
                            Icons.check_circle_outline_outlined,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Flexible(
                          child: DelayedDisplay(
                            delay: Duration(milliseconds: 600),
                            child: Text(
                              'Payment successfully',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : BlocBuilder<CartCubit, CartState>(
                      builder: (_, state) {
                        final cartCubit = context.read<CartCubit>();
                        return Center(
                          child: SizedBox(
                            width: 200,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40.0, vertical: 16.0),
                                primary: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              child: isLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        backgroundColor: Colors.white,
                                      ),
                                    )
                                  : const Text(
                                      'Buy order',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                              onPressed: cartCubit.cartList.isEmpty
                                  ? null
                                  : isLoading
                                      ? () {}
                                      : () async => orderCubit
                                              .payOrder(cartCubit.cartList)
                                              .then(
                                            (value) async {
                                              if (value == true) {
                                                await cartCubit.clearCarts();
                                                await orderCubit
                                                    .showAnimationSuccess();
                                                Navigator.pop(context);
                                              }
                                            },
                                          ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
        );
      },
    );
  }
}
