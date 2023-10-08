import 'package:flutter/material.dart';
import 'package:flutter_magnit/models/product.dart';
import 'package:flutter_magnit/models/property.dart';
import 'package:flutter_magnit/models/shop.dart';
import 'package:flutter_magnit/resources/boxes.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app.dart';

Future<void> main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(ShopModelAdapter());
  Hive.registerAdapter(ProductModelAdapter());
  Hive.registerAdapter(PropertyModelAdapter());

  await Hive.openBox<ShopModel>(Boxes.shopsBox);
  await Hive.openBox<List<ProductModel>>(Boxes.productsBox);
  await Hive.openBox<List<PropertyModel>>(Boxes.propertysBox);

  runApp(const MyApp());
}
