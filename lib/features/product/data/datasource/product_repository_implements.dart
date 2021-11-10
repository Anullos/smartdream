import 'package:smartdream/features/product/data/products_data.dart';
import 'package:smartdream/features/product/domain/models/product_model.dart';
import 'package:smartdream/features/product/domain/repository/product_repository_interface.dart';

class ProductRepositoryImplements extends ProductRepositoryInterface {
  @override
  Future<List<ProductModel>?> getAllProducts() async {
    final products = productsData;
    return products;
  }
}
