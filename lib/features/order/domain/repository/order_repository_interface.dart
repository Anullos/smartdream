import 'package:smartdream/features/order/domain/models/order_model.dart';

abstract class OrderRepositoryInterface{
  Future<bool> payOrder(OrderModel order);
}