// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// import 'package:flutter/foundation.dart';

// class UserModel {
//   final String fullName;
//   final String email;
//   final String profilePic;
//   final String phoneNumber;
//   final List favProducts;
//   UserModel({
//     required this.fullName,
//     required this.email,
//     required this.profilePic,
//     required this.phoneNumber,
//     required this.favProducts,
//   });

//   UserModel copyWith({
//     String? fullName,
//     String? email,
//     String? profilePic,
//     String? phoneNumber,
//     List? favProducts,
//   }) {
//     return UserModel(
//       fullName: fullName ?? this.fullName,
//       email: email ?? this.email,
//       profilePic: profilePic ?? this.profilePic,
//       phoneNumber: phoneNumber ?? this.phoneNumber,
//       favProducts: favProducts ?? this.favProducts,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'fullName': fullName,
//       'email': email,
//       'profilePic': profilePic,
//       'phoneNumber': phoneNumber,
//       'favProducts': favProducts,
//     };
//   }

//   factory UserModel.fromMap(Map<String, dynamic> map) {
//     return UserModel(
//       fullName: map['fullName'] as String,
//       email: map['email'] as String,
//       profilePic: map['profilePic'] as String,
//       phoneNumber: map['phoneNumber'] as String,
//       favProducts: List.from(
//         (map['favProducts'] as List),
//       ),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory UserModel.fromJson(String source) =>
//       UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() {
//     return 'UserModel(fullName: $fullName, email: $email, profilePic: $profilePic, phoneNumber: $phoneNumber, favProducts: $favProducts)';
//   }

//   @override
//   bool operator ==(covariant UserModel other) {
//     if (identical(this, other)) return true;

//     return other.fullName == fullName &&
//         other.email == email &&
//         other.profilePic == profilePic &&
//         other.phoneNumber == phoneNumber &&
//         listEquals(other.favProducts, favProducts);
//   }

//   @override
//   int get hashCode {
//     return fullName.hashCode ^
//         email.hashCode ^
//         profilePic.hashCode ^
//         phoneNumber.hashCode ^
//         favProducts.hashCode;
//   }
// }
