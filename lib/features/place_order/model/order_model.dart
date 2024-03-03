// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:e_commerce_app/features/address/model/address_model.dart';
import 'package:e_commerce_app/features/cart/model/cart_model.dart';
import 'package:e_commerce_app/features/credit_debit_card/model/card_model.dart';

class OrderModel {
  final String orderId;
  final String orderedAt;
  final AddressModel address;
  final List<CartModel> itemsOrdered;
  final CreditDebitCardModel payment;
  OrderModel({
    required this.orderId,
    required this.itemsOrdered,
    required this.orderedAt,
    required this.address,
    required this.payment,
  });

  OrderModel copyWith({
    String? orderId,
    List<CartModel>? itemsOrdered,
    String? orderedAt,
    AddressModel? address,
    CreditDebitCardModel? payment,
  }) {
    return OrderModel(
      orderId: orderId ?? this.orderId,
      itemsOrdered: itemsOrdered ?? this.itemsOrdered,
      orderedAt: orderedAt ?? this.orderedAt,
      address: address ?? this.address,
      payment: payment ?? this.payment,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderId': orderId,
      'itemsOrdered': itemsOrdered.map((x) => x.toMap()).toList(),
      'orderedAt': orderedAt,
      'address': address.toMap(),
      'payment': payment.toMap(),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      orderId: map['orderId'] as String,
      itemsOrdered: List<CartModel>.from(
        (map['itemsOrdered'] as List<int>).map<CartModel>(
          (x) => CartModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      orderedAt: map['orderedAt'] as String,
      address: AddressModel.fromMap(map['address'] as Map<String, dynamic>),
      payment:
          CreditDebitCardModel.fromMap(map['payment'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderModel(orderId: $orderId, itemsOrdered: $itemsOrdered, orderedAt: $orderedAt, address: $address, payment: $payment)';
  }

  @override
  bool operator ==(covariant OrderModel other) {
    if (identical(this, other)) return true;

    return other.orderId == orderId &&
        listEquals(other.itemsOrdered, itemsOrdered) &&
        other.orderedAt == orderedAt &&
        other.address == address &&
        other.payment == payment;
  }

  @override
  int get hashCode {
    return orderId.hashCode ^
        itemsOrdered.hashCode ^
        orderedAt.hashCode ^
        address.hashCode ^
        payment.hashCode;
  }
}
