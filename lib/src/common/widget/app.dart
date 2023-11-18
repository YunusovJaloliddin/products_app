import 'package:flutter/material.dart';
import 'package:products_app/src/common/storage/storage.dart';
import 'package:provider/provider.dart';

import '../../features/widget/controller/my_provider.dart';
import '../../features/widget/home_page/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: $products),
        ChangeNotifierProvider(create: (context) => ProjectModel()),
      ],
      child: Consumer<ProjectModel>(builder: (context, projectModel, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(scaffoldBackgroundColor: Colors.black),
          home: const HomePage(),
        );
      }),
    );
  }
}
