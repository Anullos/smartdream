import 'package:smartdream/features/cart/data/cart_data.dart';
import 'package:smartdream/features/cart/domain/models/cart_model.dart';
import 'package:smartdream/features/cart/domain/repository/cart_repository_interface.dart';

class CartRepositoryImplements extends CartRepositoryInterface {
  @override
  Future<List<CartModel>?> getCartList() async {
    return cartsData;
  }

  @override
  Future<List<CartModel>?> addCart(CartModel cartModel) async {
    for (CartModel cart in cartsData) {
      if (cart.product.id == cartModel.product.id) {
        cart.quantity += cartModel.quantity;
        return cartsData;
      }
    }
    cartsData.add(cartModel);
    return cartsData;
  }

  @override
  Future<List<CartModel>?> deleteCart(CartModel cartModel) async {
    cartsData.remove(cartModel);
    return cartsData;
  }

  @override
  Future<List<CartModel>?> updateCart(CartModel cartModel, int quantity) async {
    for (CartModel cart in cartsData) {
      if (cart.product.id == cartModel.product.id) {
        cart.quantity = quantity;
        return cartsData;
      }
    }
    return cartsData;
  }

  @override
  Future<List<CartModel>?> clearCarts() async {
    cartsData = [];
    return cartsData;
  }
}
