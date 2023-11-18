import 'package:flutter/material.dart';

import '../../../../common/storage/storage.dart';


class SaveProduct extends StatefulWidget {
  const SaveProduct({
    Key? key,
  }) : super(key: key);

  @override
  State<SaveProduct> createState() => _SaveProductState();
}

class _SaveProductState extends State<SaveProduct> {

  @override
  void initState() {
    get();
    super.initState();
  }

  void get()async{
    await $products.getProducts();
    await $products.getPrice();
  }

  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("All Price: ${$products.price.toStringAsFixed(2)} \$"),
      ),
      body: ListView.separated(
        itemCount: $products.savedProducts.length,
        separatorBuilder: (context, index) =>
            SizedBox(height: size.height * 0.05),
        itemBuilder: (context, index) => Card(
          child: Column(
            children: [
              Text($products.savedProducts[index].title),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: size.width,
                  maxHeight: size.height * 0.2,
                ),
                child: Image(
                  image: NetworkImage($products.savedProducts[index].image),
                ),
              ),
              Text($products.savedProducts[index].description),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Price: ${$products.savedProducts[index].price}\$",
                    style: TextStyle(
                      fontSize: size.height * 0.015,
                      fontWeight: FontWeight.w700,
                      color: Colors.deepPurple,
                    ),
                  ),
                  Text(
                    "Category: ${$products.savedProducts[index].category}",
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
        ),
      ),
    );
  }
}
