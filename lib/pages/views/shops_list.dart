import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_magnit/models/filter.dart';
import 'package:flutter_magnit/models/shop.dart';
import 'package:flutter_magnit/pages/bloc/shops_list_bloc.dart';
import 'package:flutter_magnit/pages/widgets/shop_filter_dialog.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final shopsListBlock = ShopListBloc();

  @override
  void initState() {
    shopsListBlock.add(GetShopsList());
    super.initState();
  }

  void filterShopsList(Filter filter) {
    shopsListBlock.add(GetShopsListFilter(filter));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopListBloc, ShopListState>(
      bloc: shopsListBlock,
      builder: (context, state) {
        if (state is ShopListLoaded) {
          return Scaffold(
            appBar: AppBar(
              actions: <Widget>[
                IconButton(
                    icon: const Icon(
                      Icons.filter_list_rounded,
                    ),
                    onPressed: () => showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              SearchDialog(filterShopsList: filterShopsList),
                        )),
                IconButton(
                    onPressed: () => Navigator.popAndPushNamed(context, '/'),
                    icon: const Icon(
                      Icons.refresh,
                    ))
              ],
              scrolledUnderElevation: 0,
              title: const Text("Список магазинов"),
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
                  itemCount: state.shopsList.length,
                  itemBuilder: (context, i) {
                    final shop = state.shopsList[i];
                    return ShopTile(shop: shop);
                  },
                  separatorBuilder: (context, index) => const Divider()),
            ),
          );
        }
        if (state is ShopListFailure) {
          return const Center(child: Text("Something went wrong"));
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class ShopTile extends StatelessWidget {
  const ShopTile({
    super.key,
    required this.shop,
  });

  final ShopModel shop;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed('/shop', arguments: shop);
      },
      title: Text(shop.name),
    );
  }
}
