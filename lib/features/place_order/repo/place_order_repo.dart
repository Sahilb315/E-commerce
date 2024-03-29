import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/features/address/model/address_model.dart';
import 'package:e_commerce_app/features/cart/model/cart_model.dart';
import 'package:e_commerce_app/features/credit_debit_card/model/card_model.dart';
import 'package:e_commerce_app/features/place_order/model/order_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PlaceOrderRepo {
  Future<void> addOrderInFirestore(OrderModel orderModel) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .update({
        'orders': FieldValue.arrayUnion([orderModel.toMap()])
      });
    } catch (e) {
      log("Place Order Repo $e");
    }
  }

  Future<List<CartModel>> getCartItems() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .get();
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      List cartList = data['cartItems'] as List;

      return cartList.map((e) => CartModel.fromMap(e)).toList();
    } catch (e) {
      log("Place Order Repo $e");
      return [];
    }
  }

  Future<AddressModel?> getCurrentAddress() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .get();
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      List address = data['addressList'] as List;
      Map<String, dynamic> currentAddress = address.firstWhere(
          (element) => element['isSelected'] == true,
          orElse: () => {});
      return AddressModel.fromMap(currentAddress);
    } catch (e) {
      log("Place Order Repo $e");
      return null;
    }
  }

  Future<CreditDebitCardModel?> getCurrentPaymentOptionSelected() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .get();
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      List cards = data['cardList'] as List;
      Map<String, dynamic> currentCard = cards.firstWhere(
          (element) => element['isSelected'] == true,
          orElse: () => {});
      return CreditDebitCardModel.fromMap(currentCard);
    } catch (e) {
      log("Place Order Repo $e");
      return null;
    }
  }
}
