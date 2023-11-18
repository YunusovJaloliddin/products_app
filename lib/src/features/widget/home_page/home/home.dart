import 'package:flutter/material.dart';
import 'package:products_app/src/common/services/service.dart';
import 'package:products_app/src/common/storage/storage.dart';
import 'package:products_app/src/features/widget/controller/my_provider.dart';
import 'package:provider/provider.dart';

import '../../../data/repository.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final IProductRepository repository;

  @override
  void initState() {
    repository = ProductRepositoryImpl(APIService());
    super.initState();
    context
        .read<ProjectModel>()
        .getAllProducts(ProductRepositoryImpl(APIService()));
  }

  void setItem() =>
      context.read<ProjectModel>().setItem($products.savedProducts.length);

  @override
  Widget build(BuildContext context) {
    final products = context.watch<ProjectModel>().allProducts;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView.separated(
        itemCount: products.length,
        separatorBuilder: (context, index) =>
            SizedBox(height: size.height * 0.05),
        itemBuilder: (context, index) {
          ValueNotifier<int> savedProduct =
              ValueNotifier<int>(products[index].rating["count"]!.toInt());
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
                SizedBox(height: size.height * 0.01),
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
                    ValueListenableBuilder(
                        valueListenable: savedProduct,
                        builder: (context, value, child) {
                          return Text("Count: $value");
                        }),
                    Text(
                      "Category: ${products[index].category}",
                      style: TextStyle(
                        fontSize: size.height * 0.015,
                        fontWeight: FontWeight.w700,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 30,
                        ),
                        SizedBox(width: size.width * 0.02),
                        Text("${products[index].rating["rate"]}"),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            savedProduct.value++;
                            await $products.reduceProduct(products[index]);
                            setItem();
                          },
                          icon: const Icon(Icons.delete),
                        ),
                        SizedBox(width: size.width * 0.05),
                        IconButton(
                          onPressed: () async {
                            savedProduct.value--;
                            await $products.addProduct(products[index]);
                            setItem();
                          },
                          icon: const Icon(Icons.inventory_2_outlined),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
