import 'package:flutter/material.dart';
import 'package:flutter_magnit/models/product.dart';
import 'package:flutter_magnit/models/shop.dart';
import 'package:flutter_magnit/service/shops_list.dart';

class ShopWidget extends StatefulWidget {
  const ShopWidget({super.key});

  @override
  State<ShopWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ShopWidget> {
  String? shopName;
  List<ProductModel>? productsList;

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is ShopModel) {
      shopName = args.name;
      productsList = ShopsListService().getProductsList(args.id);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(shopName ?? "..."),
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
            itemCount: productsList!.length,
            itemBuilder: (context, i) {
              final product = productsList![i];
              return ShopTestTile(product: product);
            },
            separatorBuilder: (context, index) => const Divider()),
      ),
    );
  }
}

class ShopTestTile extends StatelessWidget {
  const ShopTestTile({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed('/product', arguments: product);
      },
      title: Text(product.name),
    );
  }
}
