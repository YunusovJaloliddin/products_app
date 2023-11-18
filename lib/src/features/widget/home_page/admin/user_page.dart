import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../common/services/service.dart';
import '../../../data/repository.dart';
import '../../controller/my_provider.dart';
import 'cart_page.dart';

class UserPage extends StatefulWidget {
  final int id;

  const UserPage({required this.id, Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late final IProductRepository repository;

  @override
  void initState() {
    repository = ProductRepositoryImpl(APIService());
    super.initState();
    context.read<ProjectModel>().getUserCarts(repository, widget.id);
  }

  void getCartPage(List<Map<String, int>> products) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CartPage(products: products),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final carts = context.watch<ProjectModel>().carts;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: ListView.separated(
          itemBuilder: (context, index) => ListTile(
            title: Text("${index + 1}-Cart"),
            textColor: Colors.white,
            tileColor: Colors.deepPurpleAccent,
            subtitle: Text("${carts[index].date}"),
            onTap: () => getCartPage(carts[index].products),
          ),
          separatorBuilder: (context, index) => const Divider(),
          itemCount: carts.length,
        ),
      ),
    );
  }
}
