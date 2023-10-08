import 'package:flutter/material.dart';
import 'package:flutter_magnit/pages/view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magnit Test',
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 255, 232, 255),
          useMaterial3: true,
          dividerTheme:
              const DividerThemeData(color: Color.fromARGB(19, 0, 0, 0)),
          appBarTheme: const AppBarTheme(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(7),
              ),
            ),
            centerTitle: true,
            backgroundColor: Color.fromARGB(209, 255, 255, 255),
          )),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const MyHomePage(),
        '/shop': (context) => const ShopWidget(),
        '/product': (context) => const ProductWidget()
      },
    );
  }
}
