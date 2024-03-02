// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AddressModel {
  final String name;
  final String phoneNumber;
  final String address;
  final bool isSelected;
  AddressModel({
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.isSelected,
  });

  AddressModel copyWith({
    String? name,
    String? phoneNumber,
    String? address,
    bool? isSelected,
  }) {
    return AddressModel(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phoneNumber': phoneNumber,
      'address': address,
      'isSelected': isSelected,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      name: map['name'] as String,
      phoneNumber: map['phoneNumber'] as String,
      address: map['address'] as String,
      isSelected: map['isSelected'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressModel.fromJson(String source) => AddressModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AddressModel(name: $name, phoneNumber: $phoneNumber, address: $address, isSelected: $isSelected)';
  }

  @override
  bool operator ==(covariant AddressModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.phoneNumber == phoneNumber &&
      other.address == address &&
      other.isSelected == isSelected;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      phoneNumber.hashCode ^
      address.hashCode ^
      isSelected.hashCode;
  }
}
