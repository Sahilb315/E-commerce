// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:e_commerce_app/features/address/model/address_model.dart';
import 'package:e_commerce_app/features/home/model/product_model.dart';

class UserModel {
  final String email;
  final List<ProductModel> favProducts;
  final List<ProductModel> cartItems;
  final String fullName;
  final String phoneNumber;
  final String profilePic;
  final List<AddressModel> addressList;
  UserModel({
    required this.email,
    required this.favProducts,
    required this.cartItems,
    required this.fullName,
    required this.phoneNumber,
    required this.profilePic,
    required this.addressList,
  });

  UserModel copyWith({
    String? email,
    List<ProductModel>? favProducts,
    List<ProductModel>? cartItems,
    String? fullName,
    String? phoneNumber,
    String? profilePic,
    List<AddressModel>? addressList,
  }) {
    return UserModel(
      email: email ?? this.email,
      favProducts: favProducts ?? this.favProducts,
      cartItems: cartItems ?? this.cartItems,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePic: profilePic ?? this.profilePic,
      addressList: addressList ?? this.addressList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'favProducts': favProducts.map((x) => x.toMap()).toList(),
      'cartItems': cartItems.map((x) => x.toMap()).toList(),
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'profilePic': profilePic,
      'addressList': addressList.map((x) => x.toMap()).toList(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] as String,
      favProducts: List<ProductModel>.from((map['favProducts'] as List).map<ProductModel>((x) => ProductModel.fromMap(x as Map<String,dynamic>),),),
      cartItems: List<ProductModel>.from((map['cartItems'] as List).map<ProductModel>((x) => ProductModel.fromMap(x as Map<String,dynamic>),),),
      fullName: map['fullName'] as String,
      phoneNumber: map['phoneNumber'] as String,
      profilePic: map['profilePic'] as String,
      addressList: List<AddressModel>.from((map['addressList'] as List).map<AddressModel>((x) => AddressModel.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(email: $email, favProducts: $favProducts, cartItems: $cartItems, fullName: $fullName, phoneNumber: $phoneNumber, profilePic: $profilePic, addressList: $addressList)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.email == email &&
      listEquals(other.favProducts, favProducts) &&
      listEquals(other.cartItems, cartItems) &&
      other.fullName == fullName &&
      other.phoneNumber == phoneNumber &&
      other.profilePic == profilePic &&
      listEquals(other.addressList, addressList);
  }

  @override
  int get hashCode {
    return email.hashCode ^
      favProducts.hashCode ^
      cartItems.hashCode ^
      fullName.hashCode ^
      phoneNumber.hashCode ^
      profilePic.hashCode ^
      addressList.hashCode;
  }
}
