import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../common/storage/storage.dart';
import '../../models/product_model.dart';

class Product with ChangeNotifier {
  List<ProductModel> savedProducts = [];
  double price = 0;

  Future<void> getProducts() async {
    String products =
        await $secureStorage.read(key: StorageKeys.saveProducts.key) ?? "[]";
    savedProducts =
        List<Map<String, Object?>>.from(jsonDecode(products) as List)
            .map((e) => ProductModel.fromJson(e))
            .toList();
  }

  Future<void> getPrice() async {
    String products =
        await $secureStorage.read(key: StorageKeys.price.key) ?? "0";
    price = double.parse(products);
  }

  Future<void> addProduct(ProductModel model) async {
    savedProducts.add(model);
    price += model.price;
    await $secureStorage.write(
        key: StorageKeys.saveProducts.key,
        value: jsonEncode(savedProducts.map((e) => e.toJson()).toList()));
    await $secureStorage.write(
        key: StorageKeys.price.key, value: jsonEncode(price));
  }

  Future<void> reduceProduct(ProductModel model) async {
    await getProducts();
    int a = -1;
    for (int i = 0; i < savedProducts.length; i++) {
      if (model.id == savedProducts[i].id) {
        a = i;
        break;
      }
    }
    if (a >= 0) {
      savedProducts.removeAt(a);
      price -= model.price;
      await $secureStorage.write(
          key: StorageKeys.saveProducts.key,
          value: jsonEncode(savedProducts.map((e) => e.toJson()).toList()));
      await $secureStorage.write(
          key: StorageKeys.price.key, value: jsonEncode(price));
    }
  }
}
