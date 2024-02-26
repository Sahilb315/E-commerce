import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/features/home/model/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductDetailRepo {
  Future<bool> addProductToFavourites(ProductModel productModel) async {
    bool value = await productExistsInFavOrNot(productModel);
    if (value) {
      //* If exists remove product
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email.toString())
          .update({
        'favProducts': FieldValue.arrayRemove([productModel.toMap()])
      });
      return false;
    } else {
      //* If not exists add product
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email.toString())
          .update({
        'favProducts': FieldValue.arrayUnion([productModel.toMap()])
      });
      return true;
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

  
}
