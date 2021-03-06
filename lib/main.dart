import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kioskflutter/blocs/cart/cart_bloc.dart';
import 'package:kioskflutter/blocs/catalog/catalog_bloc.dart';
import 'package:kioskflutter/constants.dart';
import 'package:kioskflutter/repository/catalog_repo.dart';
import 'package:kioskflutter/repository/local_catalog_repo.dart';
import 'package:kioskflutter/screens/item_select.dart';
import 'package:kioskflutter/screens/menu.dart';
import 'package:kioskflutter/screens/review_order.dart';
import 'package:kioskflutter/screens/welcome.dart';

void main() {
  LicenseRegistry.addLicense(() async* {});

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyApp();
}

final ICatalogRepository catalogRepository = LocalCatalogRepository(
  "assets/data/data-food.json",
);

class _MyApp extends State<MyApp> {
  final CartBloc _cartBloc = CartBloc();
  final CatalogBloc _catalogBloc = CatalogBloc(catalogRepository);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _catalogBloc.loadCategories(),
      builder: (context, snapshot) => MultiBlocProvider(
        providers: [
          BlocProvider<CartBloc>(create: (_) => _cartBloc),
          BlocProvider<CatalogBloc>(create: (_) => _catalogBloc),
        ],
        child: MaterialApp(
          title: 'Flutter Kiosk',
          routes: {
            '/': (ctx) => const WelcomeScreen(),
            '/menu': (ctx) => const MenuPage(),
            '/review': (ctx) => const ReviewOrderContainer(),
            '/item': (ctx) => const ItemSelectContainer(),
          },
          themeMode: ThemeMode.light,
          darkTheme: darkThemeData,
          theme: lightThemeData,
          initialRoute: '/',
        ),
      ),
    );
  }
}
