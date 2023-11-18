import 'package:flutter/material.dart';
import 'package:products_app/src/common/services/service.dart';
import 'package:products_app/src/features/widget/controller/my_provider.dart';
import 'package:products_app/src/features/widget/home_page/admin/user_page.dart';
import 'package:provider/provider.dart';

import '../../../data/repository.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({Key? key}) : super(key: key);

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  late final IProductRepository repository;

  @override
  void initState() {
    repository = ProductRepositoryImpl(APIService());
    super.initState();
    context.read<ProjectModel>().getAllUsers(repository);
  }

  void getUserPage(int id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserPage(id: id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final users = context.watch<ProjectModel>().allUsers;
    return Scaffold(
      body: SafeArea(
        child: ListView.separated(
          itemBuilder: (context, index) => ListTile(
            title: Text(users[index].name.firstname),
            textColor: Colors.white,
            tileColor: Colors.deepPurpleAccent,
            onTap: () => getUserPage(users[index].id),
          ),
          separatorBuilder: (context, index) => const Divider(),
          itemCount: users.length,
        ),
      ),
    );
  }
}
