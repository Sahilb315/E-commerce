
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/features/home/model/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavouriteRepo {
  Future<List<ProductModel>> fetchFavouriteProducts() async {
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

  Future<void> deleteProductFromFavourites(ProductModel productModel) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email.toString())
        .update(
      {
        'favProducts': FieldValue.arrayRemove([productModel.toMap()]),
      },
    );
  }
}
