import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartdream/features/product/presentation/screen/home_screen.dart';
import 'package:smartdream/features/order/presentation/screen/order_screen.dart';

const String homeRoute = '/';
const String orderRoute = '/order';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Home
      case homeRoute:
        return PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) {
            return FadeTransition(
                opacity: animation1, child: const HomeScreen());
          },
        );
      // Order
      case orderRoute:
        return PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) {
            return FadeTransition(
                opacity: animation1, child: const OrderScreen());
          },
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
