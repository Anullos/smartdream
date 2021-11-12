import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartdream/features/product/domain/models/product_model.dart';
import 'package:smartdream/features/product/domain/repository/product_repository_interface.dart';

class ProductRepositoryImplements extends ProductRepositoryInterface {
  @override
  Future<List<ProductModel>?> getAllProducts() async {
    try {
      final _firestore = FirebaseFirestore.instance;
      QuerySnapshot _querySnapshot =
          await _firestore.collection('products').get();
      final allData = _querySnapshot.docs.map((doc) => doc.data()).toList();
      print(allData.first.runtimeType);
      List<ProductModel> products = List<ProductModel>.from(allData.map(
          (x) => ProductModel.fromMap(x as Map<String, dynamic>))).toList();
      return products;
    } catch (e) {
      return null;
    }
  }
}
