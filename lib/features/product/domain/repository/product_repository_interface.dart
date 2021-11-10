import 'package:smartdream/features/product/domain/models/product_model.dart';

abstract class ProductRepositoryInterface{
  Future<List<ProductModel>?> getAllProducts();
}