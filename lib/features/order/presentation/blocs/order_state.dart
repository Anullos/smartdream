abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderFailure extends OrderState {
  final String error;
  OrderFailure({required this.error});
}

class OrderSuccess extends OrderState {}
