import 'package:hive_flutter/hive_flutter.dart';

part 'property.g.dart';

@HiveType(typeId: 2)
class PropertyModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final int weight;

  @HiveField(2)
  final String prodictId;

  PropertyModel(
      {required this.id, required this.weight, required this.prodictId});
}
