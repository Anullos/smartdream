import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:smartdream/features/cart/domain/models/cart_model.dart';

class OrderModel {
  final String? id;
  final String userId;
  final List<CartModel> carts;
  final int totalProducts;
  final double totalPrice;
  final String status;
  final DateTime createdAt;
  OrderModel({
    this.id,
    required this.userId,
    required this.carts,
    required this.totalProducts,
    required this.totalPrice,
    required this.status,
    required this.createdAt,
  });

  OrderModel copyWith({
    String? id,
    String? userId,
    List<CartModel>? carts,
    int? totalProducts,
    double? totalPrice,
    String? status,
    DateTime? createdAt,
  }) {
    return OrderModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      carts: carts ?? this.carts,
      totalProducts: totalProducts ?? this.totalProducts,
      totalPrice: totalPrice ?? this.totalPrice,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'carts': carts.map((x) => x.toMap()).toList(),
      'totalProducts': totalProducts,
      'totalPrice': totalPrice,
      'status': status,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'],
      userId: map['userId'],
      carts: List<CartModel>.from(map['carts'].map((x) => CartModel.fromMap(x))),
      totalProducts: map['totalProducts'],
      totalPrice: map['totalPrice'],
      status: map['status'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) => OrderModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderModel(id: $id, userId: $userId, carts: $carts, totalProducts: $totalProducts, totalPrice: $totalPrice, status: $status, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is OrderModel &&
      other.id == id &&
      other.userId == userId &&
      listEquals(other.carts, carts) &&
      other.totalProducts == totalProducts &&
      other.totalPrice == totalPrice &&
      other.status == status &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      userId.hashCode ^
      carts.hashCode ^
      totalProducts.hashCode ^
      totalPrice.hashCode ^
      status.hashCode ^
      createdAt.hashCode;
  }
}
