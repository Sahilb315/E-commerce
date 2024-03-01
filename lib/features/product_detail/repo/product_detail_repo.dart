import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/features/cart/model/cart_model.dart';
import 'package:e_commerce_app/features/home/model/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductDetailRepo {
  Future<void> addProductToFavourites(ProductModel productModel) async {
    bool value = await productExistsInFavOrNot(productModel);
    if (value) {
      //* If exists remove product
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email.toString())
          .update({
        'favProducts': FieldValue.arrayRemove([productModel.toMap()])
      });
    } else {
      //* If not exists add product
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email.toString())
          .update({
        'favProducts': FieldValue.arrayUnion([productModel.toMap()])
      });
    }
  }

  Future<bool> productExistsInFavOrNot(ProductModel productModel) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email.toString())
        .get();
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    List favs = data['favProducts'];
    List<ProductModel> favProducts =
        favs.map((e) => ProductModel.fromMap(e)).toList();
    if (favProducts.contains(productModel)) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<ProductModel>> fetchFavProducts() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email.toString())
        .get();
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    List favs = data['favProducts'];
    List<ProductModel> favProducts =
        favs.map((e) => ProductModel.fromMap(e)).toList();
    return favProducts;
  }

  Future<List<ProductModel>> fetchCartProducts() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email.toString())
        .get();
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    List cart = data['cartItems'];
    List<ProductModel> cartProducts =
        cart.map((e) => ProductModel.fromMap(e)).toList();
    return cartProducts;
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

  Future<List<CartModel>> getCartItems(CartModel cartModel) async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .get();

      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      List list = data['cartItems'];
      List<CartModel> cartList = list.map((e) => CartModel.fromMap(e)).toList();

      return cartList;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<void> addProductToCart(CartModel cartModel) async {
    try {
      /// If product is already in cart then it will return the product count (which will be >1)
      /// But if product is not in cart the itemCount will be 1 which means a new product will be added
      int count = await getCartItemsCount(cartModel) ?? 1;
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .get();

      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      List list = data['cartItems'];

      /// If the product is already in cart then Getting the index of the product and incrementing the itemCount of that product
      int indexToUpdate =
          list.indexWhere((item) => item['asin'] == cartModel.asin);
      if (indexToUpdate != -1) {
        list[indexToUpdate] = {
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

        // Update the cartItems field in Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.email)
            .update({
          'cartItems': list,
        });
      } else {
        /// Its a new product which will be added to the cart
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.email)
            .update({
          'cartItems': FieldValue.arrayUnion([cartModel.toMap()]),
        });
      }
    } catch (e) {
      log("Product Detail Repo Add Product To Cart Error: $e");
    }
  }

  
}
