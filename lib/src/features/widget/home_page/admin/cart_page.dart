import 'package:flutter/material.dart';
import 'package:products_app/src/common/services/service.dart';
import 'package:products_app/src/features/widget/controller/my_provider.dart';
import 'package:provider/provider.dart';

import '../../../data/repository.dart';
import '../../../models/product_model.dart';

class CartPage extends StatefulWidget {
  final List<Map<String, int>> products;

  const CartPage({required this.products, Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late IProductRepository repository;

  @override
  void initState() {
    repository = ProductRepositoryImpl(APIService());
    super.initState();
    context.read<ProjectModel>().getCartProducts(widget.products, repository);
  }

  @override
  Widget build(BuildContext context) {
    List<ProductModel> products = context.watch<ProjectModel>().userCartProducts;
    final size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: ListView.separated(
          itemCount: products.length,
          separatorBuilder: (context, index) =>
              SizedBox(height: size.height * 0.05),
          itemBuilder: (context, index) {
            return Card(
              child: Column(
                children: [
                  Text(products[index].title),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: size.width,
                      maxHeight: size.height * 0.2,
                    ),
                    child: Image(
                      image: NetworkImage(products[index].image),
                    ),
                  ),
                  Text(products[index].description),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Price: ${products[index].price}\$",
                        style: TextStyle(
                          fontSize: size.height * 0.015,
                          fontWeight: FontWeight.w700,
                          color: Colors.deepPurple,
                        ),
                      ),
                      Text("${widget.products[index]["quantity"]}"),
                      Text(
                        "Category: ${products[index].category}",
                        style: TextStyle(
                          fontSize: size.height * 0.015,
                          fontWeight: FontWeight.w700,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
