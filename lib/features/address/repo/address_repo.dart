import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/features/address/model/address_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddressRepo {
  Future<List<AddressModel>> getAddressList() async {
    final user = FirebaseAuth.instance.currentUser;
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.email)
        .get();
    final data = snapshot.data() as Map<String, dynamic>;
    final addressList = data['addressList'] as List;
    return addressList.map((e) => AddressModel.fromMap(e)).toList();
  }

  Future<void> addNewAddress(AddressModel addressModel) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .update({
      'addressList': FieldValue.arrayUnion([addressModel.toMap()]),
    });
  }

  Future<void> deleteAddress(AddressModel addressModel) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .update({
      'addressList': FieldValue.arrayRemove([addressModel.toMap()]),
    });
  }

  Future<void> editAddress(AddressModel updatedAddressModel, AddressModel previousAddressModel) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .update({
      'addressList': FieldValue.arrayRemove([previousAddressModel.toMap()]),
    });
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .update({
      'addressList': FieldValue.arrayUnion([updatedAddressModel.toMap()]),
    });
  }
}
