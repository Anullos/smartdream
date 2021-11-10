import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartdream/features/cart/domain/models/cart_model.dart';
import 'package:smartdream/features/product/domain/models/product_model.dart';
import 'package:smartdream/features/cart/domain/repository/cart_repository_interface.dart';
import 'package:smartdream/core/shared/presentation/blocs/cart/cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepositoryInterface cartRepositoryInterface;
  CartCubit({required this.cartRepositoryInterface}) : super(CartInitial());

  List<CartModel> cartList = [];

  // get cart list
  void init() async {
    emit(CartLoading());
    final carts = await cartRepositoryInterface.getCartList();
    if (carts != null) {
      cartList = carts;
      emit(CartSuccess(cartItems: carts));
    } else {
      emit(CartFailure(error: 'Problem with load the cart, try again'));
    }
  }

  // add product to cart
  Future<bool> addCart(ProductModel product, int quantity) async {
    emit(CartLoading());
    final cart = _buildCart(product, quantity);
    final carts = await cartRepositoryInterface.addCart(cart);
    if (carts != null) {
      cartList = carts;
      emit(CartSuccess(cartItems: carts));
      return true;
    } else {
      emit(CartFailure(error: 'Problem with add product, try again'));
      return false;
    }
  }

  // build cart
  CartModel _buildCart(ProductModel product, int quantity) {
    CartModel cart = CartModel(
      product: product,
      quantity: quantity,
    );
    return cart;
  }

  // remove product from cart
  Future<void> removeCart(CartModel cartProduct) async {
    emit(CartLoading());
    final carts = await cartRepositoryInterface.deleteCart(cartProduct);
    if (carts != null) {
      cartList = carts;
      emit(CartSuccess(cartItems: carts));
    } else {
      emit(CartFailure(error: 'Problem with remove product, try again'));
    }
  }

  // update quantity cart
  Future<void> updateCart(CartModel cartProduct, int quantity) async {
    if (quantity == 0) {
      return;
    }
    emit(CartLoading());
    final carts = await cartRepositoryInterface.updateCart(cartProduct, quantity);
    if (carts != null) {
      cartList = carts;
      emit(CartSuccess(cartItems: carts));
    } else {
      emit(CartFailure(error: 'Problem with update quantity, try again'));
    }
  }

  // clear cart
  Future<void> clearCarts() async {
    emit(CartLoading());
    final carts = await cartRepositoryInterface.clearCarts();
    if (carts != null) {
      cartList = carts;
      emit(CartSuccess(cartItems: carts));
    } else {
      cartList = [];
      emit(CartFailure(error: 'Problem with clear cart, try again'));
    }
  }
}
