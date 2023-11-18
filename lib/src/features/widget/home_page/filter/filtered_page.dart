import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../common/services/service.dart';
import '../../../data/repository.dart';
import '../../controller/my_provider.dart';

class FilteredPage extends StatefulWidget {
  const FilteredPage({Key? key}) : super(key: key);

  @override
  State<FilteredPage> createState() => _FilteredPageState();
}

class _FilteredPageState extends State<FilteredPage> {
  late final IProductRepository repository;
  List<ProductType> movieTypes = [
    ProductType(type: "Jewelery"),
    ProductType(type: "Electronics"),
    ProductType(type: "Men's clothing"),
    ProductType(type: "Women's clothing"),
  ];

  @override
  void initState() {
    repository = ProductRepositoryImpl(APIService());
    super.initState();
    context.read<ProjectModel>().getCategoryProducts(repository);
  }

  void changeState(int index) {
      movieTypes[index].isSelected.value = !movieTypes[index].isSelected.value;
      context.read<ProjectModel>().selectedChips(index);
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ProjectModel>();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: size.height*0.12),
              child: ListView.separated(
                itemCount: model.resultProducts.length,
                separatorBuilder: (context, index) =>
                    SizedBox(height: size.height * 0.05),
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: [
                        Text(model.resultProducts[index].title),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: size.width,
                            maxHeight: size.height * 0.2,
                          ),
                          child: Image(
                            image:
                                NetworkImage(model.resultProducts[index].image),
                          ),
                        ),
                        Text(model.resultProducts[index].description),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Price: ${model.resultProducts[index].price}\$",
                              style: TextStyle(
                                fontSize: size.height * 0.015,
                                fontWeight: FontWeight.w700,
                                color: Colors.deepPurple,
                              ),
                            ),
                            Text(
                              "Category: ${model.resultProducts[index].category}",
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
            Wrap(
              spacing: 8,
              runSpacing: 12,
              children: List.generate(
                movieTypes.length,
                    (index) => ValueListenableBuilder(
                    valueListenable: movieTypes[index].isSelected,
                    builder: (context, value, child) {
                      return InputChip(
                        label: Text(
                          movieTypes[index].type,
                          style: TextStyle(
                            color: value
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        shape: const StadiumBorder(),
                        checkmarkColor: Colors.black,
                        showCheckmark: true,
                        backgroundColor: value
                            ? Colors.lightBlueAccent.shade100
                            : Colors.white,
                        onPressed: () => changeState(index),
                      );
                    }
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductType {
  final String type;
  ValueNotifier<bool> isSelected;

  ProductType({
    required this.type,
  }) : isSelected = ValueNotifier<bool>(false);
}
