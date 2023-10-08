import 'package:flutter/material.dart';
import 'package:flutter_magnit/models/filter.dart';

class SearchDialog extends StatefulWidget {
  final void Function(Filter) filterShopsList;
  const SearchDialog({super.key, required this.filterShopsList});

  @override
  State<SearchDialog> createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text('Фильтр')),
      content: MyCustomForm(filterShopsList: widget.filterShopsList),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  final void Function(Filter) filterShopsList;
  const MyCustomForm({super.key, required this.filterShopsList});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Map textFieldsValue = {};

    return SizedBox(
      height: 250,
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Expanded(
              child: TextFormField(
                validator: (value) {
                  if (value == "") {
                    return "Введите название";
                  }
                  textFieldsValue["name"] = value!;
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Введите название продукта',
                  labelText: 'Название продукта',
                ),
              ),
            ),
            Expanded(
              child: TextFormField(
                validator: (value) {
                  if (value != "") {
                    textFieldsValue["weight"] = int.tryParse(value!);
                    return textFieldsValue["weight"] == null
                        ? "Введите число"
                        : null;
                  }
                  textFieldsValue["weight"] = 0;
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Введите вес продукта в кг',
                  labelText: 'Вес продукта',
                ),
              ),
            ),
            ElevatedButton(
              child: const Text('Применить фильтр'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  var filter = Filter(
                      textFieldsValue["name"], textFieldsValue["weight"]);
                  widget.filterShopsList(filter);
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
