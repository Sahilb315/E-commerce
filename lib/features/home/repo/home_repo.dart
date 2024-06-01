import 'dart:convert';
import 'dart:developer';

import 'package:e_commerce_app/constants/api_key.dart';
import 'package:e_commerce_app/features/home/model/product_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class HomeRepo {
  List<ProductModel> productsList = [];

  Future<List<ProductModel>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(dotenv.env['API_URL'].toString()));
      List data = jsonDecode(response.body);
      List<ProductModel> products = [];
      if (response.statusCode == 200) {
        products =
            data.map((product) => ProductModel.fromMap(product)).toList();
      }
      productsList = products;
      return products;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<List<ProductModel>> fetchBestSellerProducts() async {
    try {
      final response = await http.get(Uri.parse(dotenv.env['API_URL'].toString()));
      List data = jsonDecode(response.body);
      List<ProductModel> products = [];
      if (response.statusCode == 200) {
        List<ProductModel> items = [];
        for (var element in data) {
          if (element['isBestSeller'] == true) {
            items.add(ProductModel.fromMap(element));
          }
        }
        products = items;
      }
      return products;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
