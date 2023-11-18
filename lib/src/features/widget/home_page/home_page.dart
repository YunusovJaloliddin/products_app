import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import 'admin/admin_panel.dart';
import 'custom_navigator_bar.dart';
import 'filter/filtered_page.dart';
import 'home/home.dart';
import 'save/saved_poducts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final PageController controller;
  List<ProductModel> products = [];

  @override
  void initState() {
    controller = PageController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(
        controller: controller,
      ),
      body: SafeArea(
        child: PageView(
          controller: controller,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            Home(),
            FilteredPage(),
            SaveProduct(),
            AdminPanel(),
          ],
        ),
      ),
    );
  }
}
