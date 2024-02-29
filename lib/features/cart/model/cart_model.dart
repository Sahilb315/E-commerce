// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class CartModel {
  final String? asin;
  final String? title;
  final String? imgUrl;
  final String? productURL;
  final dynamic stars;
  final int? reviews;
  final dynamic price;
  final dynamic listPrice;
  final int? category_id;
  final bool? isBestSeller;
  final int? boughtInLastMonth;
  int? totalItemCount;
  CartModel({
    this.asin,
    this.title,
    this.imgUrl,
    this.productURL,
    required this.stars,
    this.reviews,
    required this.price,
    required this.listPrice,
    this.category_id,
    this.isBestSeller,
    this.boughtInLastMonth,
    this.totalItemCount = 0,
  });

  CartModel copyWith({
    String? asin,
    String? title,
    String? imgUrl,
    String? productURL,
    dynamic stars,
    int? reviews,
    dynamic price,
    dynamic listPrice,
    int? category_id,
    bool? isBestSeller,
    int? boughtInLastMonth,
    int? totalItemCount,
  }) {
    return CartModel(
      asin: asin ?? this.asin,
      title: title ?? this.title,
      imgUrl: imgUrl ?? this.imgUrl,
      productURL: productURL ?? this.productURL,
      stars: stars ?? this.stars,
      reviews: reviews ?? this.reviews,
      price: price ?? this.price,
      listPrice: listPrice ?? this.listPrice,
      category_id: category_id ?? this.category_id,
      isBestSeller: isBestSeller ?? this.isBestSeller,
      boughtInLastMonth: boughtInLastMonth ?? this.boughtInLastMonth,
      totalItemCount: totalItemCount ?? this.totalItemCount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'asin': asin,
      'title': title,
      'imgUrl': imgUrl,
      'productURL': productURL,
      'stars': stars,
      'reviews': reviews,
      'price': price,
      'listPrice': listPrice,
      'category_id': category_id,
      'isBestSeller': isBestSeller,
      'boughtInLastMonth': boughtInLastMonth,
      'totalItemCount': totalItemCount,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      asin: map['asin'] != null ? map['asin'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      imgUrl: map['imgUrl'] != null ? map['imgUrl'] as String : null,
      productURL:
          map['productURL'] != null ? map['productURL'] as String : null,
      stars: map['stars'] as dynamic,
      reviews: map['reviews'] != null ? map['reviews'] as int : null,
      price: map['price'] as dynamic,
      listPrice: map['listPrice'] as dynamic,
      category_id:
          map['category_id'] != null ? map['category_id'] as int : null,
      isBestSeller:
          map['isBestSeller'] != null ? map['isBestSeller'] as bool : null,
      boughtInLastMonth: map['boughtInLastMonth'] != null
          ? map['boughtInLastMonth'] as int
          : null,
      totalItemCount:
          map['totalItemCount'] != null ? map['totalItemCount'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartModel.fromJson(String source) =>
      CartModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CartModel(asin: $asin, title: $title, imgUrl: $imgUrl, productURL: $productURL, stars: $stars, reviews: $reviews, price: $price, listPrice: $listPrice, category_id: $category_id, isBestSeller: $isBestSeller, boughtInLastMonth: $boughtInLastMonth, totalItemCount: $totalItemCount)';
  }

  @override
  bool operator ==(covariant CartModel other) {
    if (identical(this, other)) return true;

    return other.asin == asin &&
        other.title == title &&
        other.imgUrl == imgUrl &&
        other.productURL == productURL &&
        other.stars == stars &&
        other.reviews == reviews &&
        other.price == price &&
        other.listPrice == listPrice &&
        other.category_id == category_id &&
        other.isBestSeller == isBestSeller &&
        other.boughtInLastMonth == boughtInLastMonth &&
        other.totalItemCount == totalItemCount;
  }

  @override
  int get hashCode {
    return asin.hashCode ^
        title.hashCode ^
        imgUrl.hashCode ^
        productURL.hashCode ^
        stars.hashCode ^
        reviews.hashCode ^
        price.hashCode ^
        listPrice.hashCode ^
        category_id.hashCode ^
        isBestSeller.hashCode ^
        boughtInLastMonth.hashCode ^
        totalItemCount.hashCode;
  }
}
