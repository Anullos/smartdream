import 'package:smartdream/features/cart/domain/models/cart_model.dart';

abstract class CartRepositoryInterface{
  Future<List<CartModel>?> getCartList();
  Future<List<CartModel>?> addCart(CartModel cartModel);
  Future<List<CartModel>?> updateCart(CartModel cartModel, int quantity);
  Future<List<CartModel>?> deleteCart(CartModel cartModel);
  Future<List<CartModel>?> clearCarts();
}