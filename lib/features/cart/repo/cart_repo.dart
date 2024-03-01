import 'dart:developer';

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
    List<CartModel> cartProducts =
        cart.map((item) => CartModel.fromMap(item)).toList();
    if (cartProducts.isEmpty) {
      return [];
    } else {
      return cartProducts;
    }
  }

  Future<int?> getCartItemsCount(CartModel cartModel) async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .get();

      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      List list = data['cartItems'];
      List<CartModel> cartList = list.map((e) => CartModel.fromMap(e)).toList();

      for (var element in cartList) {
        if (element.asin == cartModel.asin) {
          return element.totalItemCount;
        }
      }
      return 1;
    } catch (e) {
      return 1;
    }
  }

  Future<void> incrementCartItem(CartModel cartModel) async {
    int count = await getCartItemsCount(cartModel) ?? 1;

    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email.toString())
        .get();
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    List cart = data['cartItems'];

    int indexToUpdate =
        cart.indexWhere((item) => item['asin'] == cartModel.asin);
    if (indexToUpdate != -1) {
      cart[indexToUpdate] = {
        'stars': cartModel.stars,
        'price': cartModel.price,
        'listPrice': cartModel.listPrice,
        'totalItemCount': ++count,
        'asin': cartModel.asin,
        'title': cartModel.title,
        'imgUrl': cartModel.imgUrl,
        'category_id': cartModel.category_id,
        'reviews': cartModel.reviews,
        'isBestSeller': cartModel.isBestSeller,
        'boughtInLastMonth': cartModel.boughtInLastMonth,
        'productURL': cartModel.productURL,
      };
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .update({
        'cartItems': cart,
      });
    }
  }

  Future<void> decrementCartItem(CartModel cartModel) async {
    int count = await getCartItemsCount(cartModel) ?? 1;

    if (count <= 1) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .update({
        'cartItems': FieldValue.arrayRemove([cartModel.toMap()]),
      });
    }
    log("Before $count");
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email.toString())
        .get();
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    List cart = data['cartItems'];

    int indexToUpdate =
        cart.indexWhere((item) => item['asin'] == cartModel.asin);
    if (indexToUpdate != -1) {
      cart[indexToUpdate] = {
        'stars': cartModel.stars,
        'price': cartModel.price,
        'listPrice': cartModel.listPrice,
        'totalItemCount': --count,
        'asin': cartModel.asin,
        'title': cartModel.title,
        'imgUrl': cartModel.imgUrl,
        'category_id': cartModel.category_id,
        'reviews': cartModel.reviews,
        'isBestSeller': cartModel.isBestSeller,
        'boughtInLastMonth': cartModel.boughtInLastMonth,
        'productURL': cartModel.productURL,
      };
      log("After $count");
      log("Cart ${cart.toString()}");
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .update({
        'cartItems': cart,
      });
    }
  }

  Future<void> deleteAllCartItem(CartModel cartModel) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .update({
      'cartItems': FieldValue.arrayRemove([cartModel.toMap()]),
    });
  }
}
