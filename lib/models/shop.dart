import 'package:hive_flutter/hive_flutter.dart';

part 'shop.g.dart';

@HiveType(typeId: 0)
class ShopModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  ShopModel({required this.id, required this.name});
}
