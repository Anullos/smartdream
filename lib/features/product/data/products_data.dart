import 'package:smartdream/features/product/domain/models/product_model.dart';

List<ProductModel> productsData = [
  product1,
  product2,
  product3,
  product4,
  product5,
  product6,
  product7,
];

final product1 = ProductModel(
  id: '1',
  name: 'Bocadillo de Serrano',
  description: 'Contiene tomate, aceite y jamón serrano',
  image: 'assets/images/boca1.png',
  currentPrice: 2.6,
);

final product2 = ProductModel(
  id: '2',
  name: 'Bocadillo de salmón',
  description: 'Contiene mayonesa y salmón',
  image: 'assets/images/boca2.png',
  currentPrice: 2.4,
);
final product3 = ProductModel(
  id: '3',
  name: 'Bocadillo de bacon y queso',
  description: 'Contiene bacon y queso',
  image: 'assets/images/boca3.png',
  currentPrice: 2.2,
);
final product4 = ProductModel(
  id: '4',
  name: 'Bocadillo de tortilla',
  description: 'Contiene tortilla de patatas con mayonesa',
  image: 'assets/images/boca4.png',
  currentPrice: 1.6,
);
final product5 = ProductModel(
  id: '5',
  name: 'Bocadillo de huevo y atún',
  description: 'Contiene huevo duro, atún y mayonesa',
  image: 'assets/images/boca5.png',
  currentPrice: 2.6,
);
final product6 = ProductModel(
  id: '6',
  name: 'Bocadillo macarena',
  description: 'Contiene queso, pavo y cebolla',
  image: 'assets/images/boca6.png',
  currentPrice: 2.8,
);
final product7 = ProductModel(
  id: '7',
  name: 'Bocadillo valenciano',
  description: 'Contiene lomo con verduras salteadas',
  image: 'assets/images/boca7.png',
  currentPrice: 3.2,
);
