// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CreditDebitCardModel {
  final String cardNumber;
  final String cardHolderName;
  final String expiryDate;
  final String cvvCode;
  final String bankName;
  final int colorIndex;
  final bool isSelected;
  CreditDebitCardModel({
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryDate,
    required this.cvvCode,
    required this.bankName,
    required this.colorIndex,
    required this.isSelected,
  });

  CreditDebitCardModel copyWith({
    String? cardNumber,
    String? cardHolderName,
    String? expiryDate,
    String? cvvCode,
    String? bankName,
    int? colorIndex,
    bool? isSelected,
  }) {
    return CreditDebitCardModel(
      cardNumber: cardNumber ?? this.cardNumber,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      expiryDate: expiryDate ?? this.expiryDate,
      cvvCode: cvvCode ?? this.cvvCode,
      bankName: bankName ?? this.bankName,
      colorIndex: colorIndex ?? this.colorIndex,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cardNumber': cardNumber,
      'cardHolderName': cardHolderName,
      'expiryDate': expiryDate,
      'cvvCode': cvvCode,
      'bankName': bankName,
      'colorIndex': colorIndex,
      'isSelected': isSelected,
    };
  }

  factory CreditDebitCardModel.fromMap(Map<String, dynamic> map) {
    return CreditDebitCardModel(
      cardNumber: map['cardNumber'] as String,
      cardHolderName: map['cardHolderName'] as String,
      expiryDate: map['expiryDate'] as String,
      cvvCode: map['cvvCode'] as String,
      bankName: map['bankName'] as String,
      colorIndex: map['colorIndex'] as int,
      isSelected: map['isSelected'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreditDebitCardModel.fromJson(String source) => CreditDebitCardModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CreditCardModel(cardNumber: $cardNumber, cardHolderName: $cardHolderName, expiryDate: $expiryDate, cvvCode: $cvvCode, bankName: $bankName, colorIndex: $colorIndex, isSelected: $isSelected)';
  }

  @override
  bool operator ==(covariant CreditDebitCardModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.cardNumber == cardNumber &&
      other.cardHolderName == cardHolderName &&
      other.expiryDate == expiryDate &&
      other.cvvCode == cvvCode &&
      other.bankName == bankName &&
      other.colorIndex == colorIndex &&
      other.isSelected == isSelected;
  }

  @override
  int get hashCode {
    return cardNumber.hashCode ^
      cardHolderName.hashCode ^
      expiryDate.hashCode ^
      cvvCode.hashCode ^
      bankName.hashCode ^
      colorIndex.hashCode ^
      isSelected.hashCode;
  }
}
