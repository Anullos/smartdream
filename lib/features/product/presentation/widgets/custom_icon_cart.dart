import 'package:flutter/material.dart';
import 'package:smartdream/core/shared/presentation/blocs/cart/cart_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartdream/core/shared/presentation/widgets/shake_transition.dart';
import 'package:smartdream/core/shared/presentation/blocs/cart/cart_state.dart';

class CustomIconCart extends StatelessWidget {
  final VoidCallback onTap;
  const CustomIconCart({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CartCubit>();
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 40,
        width: 50,
        child: Stack(
          children: [
            const Positioned(
              bottom: 4,
              right: 8,
              child: Icon(
                Icons.shopping_cart_outlined,
                color: Colors.white,
                size: 35,
              ),
            ),
            BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                if (bloc.cartList.isNotEmpty) {
                  return Positioned(
                    top: 8.0,
                    right: 6.0,
                    child: ShakeTransition(
                      key: UniqueKey(),
                      offset: 20,
                      child: Container(
                        child: Text(
                          bloc.cartList.length.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                        alignment: Alignment.center,
                        height: 18.0,
                        width: 18.0,
                        decoration: const BoxDecoration(
                          color: Colors.pink,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
