import 'package:smartdream/features/order/domain/models/order_model.dart';
import 'package:smartdream/features/order/domain/repository/order_repository_interface.dart';

class OrderRepositoryImplements extends OrderRepositoryInterface {
  @override
  Future<bool> payOrder(OrderModel order) async {
    return true;
  }
}
