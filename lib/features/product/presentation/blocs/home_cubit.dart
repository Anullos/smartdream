import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartdream/features/product/domain/models/product_model.dart';
import 'package:smartdream/features/product/domain/repository/product_repository_interface.dart';
import 'package:smartdream/features/product/presentation/blocs/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ProductRepositoryInterface productRepositoryInterface;
  HomeCubit({required this.productRepositoryInterface}) : super(HomeInitial());

  List<ProductModel> productList = [];

  Future<void> init() async {
    emit(HomeLoading());
    await Future.delayed(const Duration(seconds: 1));
    final products = await productRepositoryInterface.getAllProducts();
    if (products != null) {
      productList = products;
      emit(HomeSuccess(products: products));
    } else {
      emit(HomeFailure(error: 'Problem with load products'));
    }
  }
}
