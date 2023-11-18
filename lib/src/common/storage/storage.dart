import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../features/widget/controller/controller.dart';

late final FlutterSecureStorage $secureStorage;
late final Product $products;



enum StorageKeys {
  products("products"),
  saveProducts("save"),
  price("price");

  const StorageKeys(this.key);

  final String key;
}