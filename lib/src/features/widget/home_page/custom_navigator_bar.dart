import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/storage/storage.dart';
import '../controller/my_provider.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({
    required this.controller,
    super.key,
  });

  final PageController controller;

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  void initState() {
    setItem();
    super.initState();
  }

  void setItem() async {
    await $products.getProducts();
    context.read<ProjectModel>().setItem($products.savedProducts.length);
  }

  @override
  Widget build(BuildContext context) => BottomNavigationBar(
        backgroundColor: const Color(0xFFDAFFFB),
        fixedColor: const Color(0xFF116D6E),
        unselectedItemColor: const Color(0xFF73BBC9),
        showUnselectedLabels: false,
        elevation: 0,
        landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
        type: BottomNavigationBarType.fixed,
        currentIndex: context.watch<ProjectModel>().pageNumber,
        onTap: (value) =>
            context.read<ProjectModel>().pageChanger(value, widget.controller),
        showSelectedLabels: true,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.filter),
            label: "Filter",
          ),
          BottomNavigationBarItem(
            icon: Badge(
              label: Text("${context.watch<ProjectModel>().savedItem}"),
              child: const Icon(Icons.inventory_2_outlined),
            ),
            label: "Save",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.admin_panel_settings),
            label: "Admin Panel",
          ),
        ],
      );
}
