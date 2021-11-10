import 'dart:convert';

class ProductModel {
  final String id;
  final String name;
  final String description;
  final double currentPrice;
  final String image;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.currentPrice,
    this.image = 'assets/images/boca1.png',
  });

  ProductModel copyWith({
    String? id,
    String? name,
    String? description,
    double? currentPrice,
    String? image,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      currentPrice: currentPrice ?? this.currentPrice,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'currentPrice': currentPrice,
      'image': image,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      currentPrice: map['currentPrice'],
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductModel(id: $id, name: $name, description: $description, currentPrice: $currentPrice, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ProductModel &&
      other.id == id &&
      other.name == name &&
      other.description == description &&
      other.currentPrice == currentPrice &&
      other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      currentPrice.hashCode ^
      image.hashCode;
  }
}
