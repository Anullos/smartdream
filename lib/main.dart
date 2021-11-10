import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartdream/features/cart/data/datasource/cart_repository_implements.dart';
import 'package:smartdream/features/order/data/datasource/order_repository_implements.dart';
import 'package:smartdream/features/order/domain/repository/order_repository_interface.dart';
import 'package:smartdream/features/product/data/datasource/product_repository_implements.dart';
import 'package:smartdream/features/cart/domain/repository/cart_repository_interface.dart';
import 'package:smartdream/features/product/domain/repository/product_repository_interface.dart';
import 'package:smartdream/routes.dart';
import 'package:smartdream/core/shared/presentation/blocs/cart/cart_cubit.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // Initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ProductRepositoryInterface>(
          create: (_) => ProductRepositoryImplements(),
        ),
        RepositoryProvider<CartRepositoryInterface>(
          create: (_) => CartRepositoryImplements(),
        ),
        RepositoryProvider<OrderRepositoryInterface>(
          create: (_) => OrderRepositoryImplements(),
        ),
      ],
      child: BlocProvider(
        create: (context) => CartCubit(
          cartRepositoryInterface: context.read<CartRepositoryInterface>(),
        )..init(),
        child: MaterialApp(
          title: 'SmartDream',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: homeRoute,
        ),
      ),
    );
  }
}
