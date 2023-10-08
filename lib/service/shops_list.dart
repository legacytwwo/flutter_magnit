import 'dart:math';

import 'package:flutter_magnit/models/filter.dart';
import 'package:flutter_magnit/models/product.dart';
import 'package:flutter_magnit/models/property.dart';
import 'package:flutter_magnit/models/shop.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:word_generator/word_generator.dart';
import 'package:flutter_magnit/resources/boxes.dart';

class ShopsListService {
  Future<void> initState() async {
    var rng = Random();
    var uuid = const Uuid();
    final wordGenerator = WordGenerator();

    var shopBox = Hive.box<ShopModel>(Boxes.shopsBox);
    var productBox = Hive.box<List<ProductModel>>(Boxes.productsBox);
    var propertyBox = Hive.box<List<PropertyModel>>(Boxes.propertysBox);
    shopBox.deleteAll(shopBox.keys);
    productBox.deleteAll(productBox.keys);
    propertyBox.deleteAll(propertyBox.keys);

    final shopsList = List<ShopModel>.generate(
        15, (index) => ShopModel(id: uuid.v4(), name: "Магазин $index"));

    Map<String, List<ProductModel>> productModelList = {};
    Map<String, List<PropertyModel>> propertyModelList = {};

    for (var element in shopsList) {
      productModelList[element.id] = List<ProductModel>.generate(
          5,
          (index) => ProductModel(
              id: uuid.v4(),
              name: wordGenerator.randomNoun(),
              shopId: element.id));
    }

    for (var i in productModelList.values) {
      for (var j in i) {
        propertyModelList[j.id] = List<PropertyModel>.generate(
            1,
            (index) => PropertyModel(
                id: uuid.v4(), weight: rng.nextInt(100), prodictId: j.id));
      }
    }

    await shopBox.putAll({for (var e in shopsList) e.id: e});
    await productBox.putAll(productModelList);
    await propertyBox.putAll(propertyModelList);
  }

  List<ShopModel> getShopsList() {
    var shopBox = Hive.box<ShopModel>(Boxes.shopsBox);
    var shopsList = shopBox.values.toList();
    return shopsList;
  }

  List<ProductModel>? getProductsList(String id) {
    var productsBox = Hive.box<List<ProductModel>>(Boxes.productsBox);
    var productsList = productsBox.get(id);

    return productsList;
  }

  List<PropertyModel>? getPropertysList(String id) {
    var propertysBox = Hive.box<List<PropertyModel>>(Boxes.propertysBox);
    var propertysList = propertysBox.get(id);

    return propertysList;
  }

  List<ShopModel> getFilteredShopList(Filter filter) {
    List<ShopModel> result = [];
    var shopBox = Hive.box<ShopModel>(Boxes.shopsBox);
    var productsBox = Hive.box<List<ProductModel>>(Boxes.productsBox);
    var propertysBox = Hive.box<List<PropertyModel>>(Boxes.propertysBox);

    for (var i in productsBox.keys) {
      for (var j in productsBox.get(i)!) {
        if (j.name == filter.name) {
          if (filter.weight != 0) {
            var property = propertysBox.get(j.id);
            if (property![0].weight == filter.weight) {
              result.add(shopBox.get(i)!);
            }
            continue;
          }
          result.add(shopBox.get(i)!);
        }
      }
    }

    return result;
  }
}
