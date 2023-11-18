import 'dart:convert';

import 'package:products_app/src/features/models/cart_model.dart';
import 'package:products_app/src/features/models/user_model.dart';

import '../../common/constants/api_const.dart';
import '../../common/services/service.dart';
import '../models/product_model.dart';

abstract interface class IProductRepository {
  const IProductRepository();

  Future<List<ProductModel>> getAllProducts();

  Future<List<ProductModel>> searchProducts(String text);

  Future<List<CartModel>> getUserCarts(String text);

  Future<ProductModel> getProduct(String text);

  Future<List<UserModel>> getAllUsers();
}

class ProductRepositoryImpl implements IProductRepository {
  final APIService apiService;

  const ProductRepositoryImpl(this.apiService);

  @override
  Future<List<ProductModel>> getAllProducts() async {
    String response = await apiService.request(ApiConst.allProductsPath);
    List<ProductModel> base = jsonDecode(response) != null
        ? List<Map<String, Object?>>.from(jsonDecode(response) as List)
            .map(ProductModel.fromJson)
            .toList()
        : [];
    return base;
  }

  @override
  Future<List<ProductModel>> searchProducts(String text) async {
    String response = await apiService.request(ApiConst.searchProducts,
        queryParametersAll: text);

    List<ProductModel> base = jsonDecode(response) != null
        ? List<Map<String, Object?>>.from(jsonDecode(response) as List)
            .map(ProductModel.fromJson)
            .toList()
        : [];
    return base;
  }

  @override
  Future<List<UserModel>> getAllUsers() async {
    String response = await apiService.request(ApiConst.getUserPath);
    List<UserModel> base = jsonDecode(response) != null
        ? List<Map<String, Object?>>.from(jsonDecode(response) as List)
            .map(UserModel.fromJson)
            .toList()
        : [];
    return base;
  }

  @override
  Future<ProductModel> getProduct(String text) async {
    String response = await apiService.request(ApiConst.getProductPath,
        queryParametersAll: text);

    ProductModel base = ProductModel.fromJson(jsonDecode(response));
    return base;
  }

  @override
  Future<List<CartModel>> getUserCarts(String text) async {
    String response = await apiService.request(ApiConst.userCartsPath,
        queryParametersAll: text);

    List<CartModel> base = jsonDecode(response) != null
        ? List<Map<String, Object?>>.from(jsonDecode(response) as List)
            .map(CartModel.fromJson)
            .toList()
        : [];
    return base;
  }
}
