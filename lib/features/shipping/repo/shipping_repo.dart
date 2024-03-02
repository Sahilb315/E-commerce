import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/features/address/model/address_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ShippingRepo {
  Future<void> updateSelectedAddress(AddressModel addressModel) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get();
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    List addresses = data['addressList'] as List;
    for (int i = 0; i < addresses.length; i++) {
      if (addresses[i]['address'] == addressModel.address &&
          addresses[i]['phoneNumber'] == addressModel.phoneNumber &&
          addresses[i]['name'] == addressModel.name) {
        addresses[i]['isSelected'] = true;
      } else {
        addresses[i]['isSelected'] = false;
      }
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .update({
      'addressList': addresses,
    });
  }
}
