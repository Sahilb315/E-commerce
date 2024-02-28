import 'dart:convert';
import 'dart:developer';

import 'package:e_commerce_app/constants/api_key.dart';
import 'package:e_commerce_app/features/home/model/product_model.dart';
import 'package:http/http.dart' as http;

class ProductCategoryRepo {
  Future<List<ProductModel>> fetchProductsByCatgory(int categoryId) async {
    try {
      final res = await http.get(Uri.parse(API_KEY));
      List data = jsonDecode(res.body);
      List<ProductModel> categorisedList = [];
      if (res.statusCode == 200) {
        //*      Category Data
        for (int i = 0; i < data.length; i++) {
          if (data[i]['category_id'] == categoryId) {
            if (categorisedList.contains(ProductModel.fromMap(data[i]))) {
              continue;
            }
            categorisedList.add(ProductModel.fromMap(data[i]));
          }
        }
      } else {
        log("Error while Getting category data ${res.statusCode.toString()}");
      }

      return categorisedList;
    } catch (e) {
      log("Error while Getting category data ${e.toString()}");
      return [];
    }
  }
}
