import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/features/credit_debit_card/model/card_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreditCardRepo {
  Future<List<CreditDebitCardModel>> fetchAllCards() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .get();
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      List cards = data['cardList'];

      List<CreditDebitCardModel> cardsList =
          cards.map((e) => CreditDebitCardModel.fromMap(e)).toList();
      return cardsList;
    } catch (e) {
      log("Credit Card Repo Fetch All Cards Error: $e ");
      return [];
    }
  }

  Future<void> addNewCreditCard(CreditDebitCardModel cardModel) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .update({
      'cardList': FieldValue.arrayUnion([cardModel.toMap()])
    });
  }

  Future<void> deleteCreditCard(CreditDebitCardModel cardModel) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .update({
      'cardList': FieldValue.arrayRemove([cardModel.toMap()])
    });
  }

  Future<void> updateSelectedAddress(
      CreditDebitCardModel creditDebitCardModel) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get();
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    List cards = data['cardList'] as List;
    for (int i = 0; i < cards.length; i++) {
      if (cards[i]['cardNumber'] == creditDebitCardModel.cardNumber &&
          cards[i]['cvvCode'] == creditDebitCardModel.cvvCode &&
          cards[i]['expiryDate'] == creditDebitCardModel.expiryDate) {
        cards[i]['isSelected'] = true;
      } else {
        cards[i]['isSelected'] = false;
      }
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .update({
      'cardList': cards,
    });
  }
}
