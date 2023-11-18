
import 'package:flutter/material.dart';
import 'package:products_app/src/features/data/repository.dart';
import 'package:products_app/src/features/models/user_model.dart';

import '../../models/cart_model.dart';
import '../../models/product_model.dart';

class ProjectModel extends ChangeNotifier {
  int pageNumber = 0;
  List<ProductModel> jeweleryProducts = [];
  List<ProductModel> electronicsProducts = [];
  List<ProductModel> menClothingProducts = [];
  List<ProductModel> womenClothingProducts = [];
  List<ProductModel> resultProducts = [];
  List<ProductModel> allProducts = [];
  List<ProductModel> userCartProducts = [];
  List<UserModel> allUsers = [];
  List<CartModel> carts = [];
  bool electronics = false;
  bool jewelery = false;
  bool menClothing = false;
  bool womenClothing = false;
  double price = 0;
  int savedItem=0;

  void setItem(int a){
    savedItem=a;
    notifyListeners();
  }

  void getCategoryProducts(IProductRepository repository) async {
    jeweleryProducts = await repository.searchProducts("jewelery");
    electronicsProducts = await repository.searchProducts("electronics");
    menClothingProducts = await repository.searchProducts("men's clothing");
    womenClothingProducts = await repository.searchProducts("women's clothing");
  }

  void getCartProducts(List<Map<String, int>> productsList,
      IProductRepository repository) async {
    userCartProducts = [];
    for (var item in productsList) {
      ProductModel productModel =
          await repository.getProduct("${item["productId"]}");
      userCartProducts.add(productModel);
    }
    notifyListeners();
  }

  void getAllProducts(IProductRepository repository) async {
    allProducts=await repository.getAllProducts();
    notifyListeners();
  }

  void getAllUsers(IProductRepository repository) async {
    allUsers = await repository.getAllUsers();
    notifyListeners();
  }

  void getUserCarts(IProductRepository repository, int id) async {
    carts = await repository.getUserCarts("$id");
    notifyListeners();
  }

  void selectedChips(int a) {
    switch (a) {
      case 0:
        jewelery = !jewelery;
        !jewelery
            ? jeweleryProducts.forEach((element) => resultProducts.remove(element))
            : resultProducts.addAll(jeweleryProducts);
      case 1:
        electronics = !electronics;
        !electronics
            ? electronicsProducts.forEach((element) => resultProducts.remove(element))
            : resultProducts.addAll(electronicsProducts);
      case 2:
        menClothing = !menClothing;
        !menClothing
            ? menClothingProducts.forEach((element) => resultProducts.remove(element))
            : resultProducts.addAll(menClothingProducts);
      case 3:
        womenClothing = !womenClothing;
        !womenClothing
            ? womenClothingProducts.forEach((element) => resultProducts.remove(element))
            : resultProducts.addAll(womenClothingProducts);
    }
    notifyListeners();
  }

  void pageChanger(int value, PageController controller) {
    controller.jumpToPage(value);
    pageNumber = value;
    notifyListeners();
  }
}
