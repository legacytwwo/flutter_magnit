import 'package:flutter/material.dart';
import 'package:flutter_magnit/models/product.dart';
import 'package:flutter_magnit/models/property.dart';
import 'package:flutter_magnit/service/shops_list.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({super.key});

  @override
  State<ProductWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ProductWidget> {
  String? productName;
  List<PropertyModel>? propertysList;

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is ProductModel) {
      productName = args.name;
      propertysList = ShopsListService().getPropertysList(args.id);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(productName ?? "..."),
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 10,
        ),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color.fromARGB(255, 249, 249, 249),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(29, 0, 0, 0),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              )
            ]),
        child: ListView.separated(
            itemCount: propertysList!.length,
            itemBuilder: (context, i) {
              final property = propertysList![i];
              return ShopTATile(property: property);
            },
            separatorBuilder: (context, index) => const Divider()),
      ),
    );
  }
}

class ShopTATile extends StatelessWidget {
  const ShopTATile({
    super.key,
    required this.property,
  });

  final PropertyModel property;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed('/product');
      },
      title: Text("Вес: ${property.weight}"),
    );
  }
}
