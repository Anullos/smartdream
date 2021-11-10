import 'package:smartdream/features/product/domain/models/product_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeFailure extends HomeState {
  final String error;
  HomeFailure({required this.error});
}

class HomeSuccess extends HomeState {
  final List<ProductModel> products;
  HomeSuccess({required this.products});
}