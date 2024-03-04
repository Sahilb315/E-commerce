import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/features/place_order/model/order_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrderRepo {
  Future<List<OrderModel>> getAllOrders() async {
    try {
      final snap = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.email.toString())
          .get();

      final data = snap.data() as Map<String, dynamic>;
      List orderListFirestore = data['orders'] as List;
      List<OrderModel> orders =
          orderListFirestore.map((e) => OrderModel.fromMap(e)).toList();
      return orders;
    } catch (e) {
      log("Order Repo $e");
      return [];
    }
  }
}
