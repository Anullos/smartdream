import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartdream/features/cart/domain/models/cart_model.dart';
import 'package:smartdream/features/order/domain/models/order_model.dart';
import 'package:smartdream/features/order/domain/repository/order_repository_interface.dart';
import 'package:smartdream/features/order/presentation/blocs/order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepositoryInterface orderRepositoryInterface;
  OrderCubit({required this.orderRepositoryInterface}) : super(OrderInitial());

  // Payment
  Future<bool> payOrder(List<CartModel> carts) async {
    emit(OrderLoading());
    await Future.delayed(const Duration(milliseconds: 800));
    final order = _buildOrder(carts);
    final result = await orderRepositoryInterface.payOrder(order);
    if (result) {
      emit(OrderSuccess());
      return true;
    } else {
      emit(OrderFailure(error: 'Error while paying order'));
      return false;
    }
  }

  // build order
  OrderModel _buildOrder(List<CartModel> carts) {
    OrderModel order = OrderModel(
      userId: '2',
      carts: carts,
      totalProducts: carts.length,
      totalPrice: _calculateTotalPrice(carts),
      status: 'Paid Out',
      createdAt: DateTime.now(),
    );
    return order;
  }

  // Calculate total price
  double _calculateTotalPrice(List<CartModel> carts) {
    double totalPrice = 0;
    for (var cart in carts) {
      totalPrice += cart.product.currentPrice * cart.quantity;
    }
    return totalPrice;
  }

  // time show animation
  Future<void> showAnimationSuccess() async {
    await Future.delayed(const Duration(milliseconds: 2800));
    emit(OrderInitial());
  }
}
