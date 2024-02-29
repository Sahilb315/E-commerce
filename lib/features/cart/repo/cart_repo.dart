import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/features/cart/model/cart_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartRepo {
  Future<List<CartModel>> fetchCartProducts() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email.toString())
        .get();
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    List cart = data['cartItems'];
    List<CartModel> cartProducts = cart
        .map(
          (e) => CartModel(
            stars: e['stars'],
            price: e['price'],
            listPrice: e['listPrice'],
            totalItemCount: e['totalItemCount'],
            asin: e['asin'],
            title: e['title'],
            imgUrl: e['imgUrl'],
            category_id: e['category_id'],
            reviews: e['reviews'],
            isBestSeller: e['isBestSeller'],
            boughtInLastMonth: e['boughtInLastMonth'],
            productURL: e['productURL'],
          ),
        )
        .toList();
    if (cartProducts.isEmpty) {
      return [];
    } else {
      return cartProducts;
    }
  }
}
