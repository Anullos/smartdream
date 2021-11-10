import 'package:smartdream/features/cart/domain/models/cart_model.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartFailure extends CartState {
  final String error;
  CartFailure({required this.error});
}

class CartSuccess extends CartState {
  final List<CartModel> cartItems;
  CartSuccess({required this.cartItems});
}