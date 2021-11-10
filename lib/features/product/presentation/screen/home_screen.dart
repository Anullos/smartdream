import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartdream/core/shared/presentation/widgets/dialogs.dart';
import 'package:smartdream/features/product/domain/repository/product_repository_interface.dart';
import 'package:smartdream/routes.dart';
import 'package:smartdream/features/product/presentation/blocs/home_cubit.dart';
import 'package:smartdream/features/product/presentation/blocs/home_state.dart';
import 'package:smartdream/features/product/presentation/widgets/custom_icon_cart.dart';
import 'package:smartdream/features/product/presentation/widgets/item_product.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(
        productRepositoryInterface: context.read<ProductRepositoryInterface>(),
      )..init(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('SmartDream Store'),
          backgroundColor: Colors.green,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: CustomIconCart(
                onTap: () => Navigator.pushNamed(context, orderRoute),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green.shade100,
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            final homeCubit = context.read<HomeCubit>();
            if (state is HomeInitial) {
              return const Center(
                child: Text('No hay data'),
              );
            }
            if (state is HomeLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is HomeSuccess) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(16),
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return ItemProduct(
                    product: product,
                    index: index,
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => SelectionProductAlertDialog(
                        product: product,
                      ),
                    ),
                  );
                },
              );
            }
            return Center(
              child: ElevatedButton(
                onPressed: () async => await homeCubit.init(),
                child: const Text('Error, try again'),
              ),
            );
          },
        ),
      ),
    );
  }
}
