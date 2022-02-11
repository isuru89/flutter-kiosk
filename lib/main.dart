import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kioskflutter/blocs/cart/cart_bloc.dart';
import 'package:kioskflutter/blocs/catalog/catalog_bloc.dart';
import 'package:kioskflutter/constants.dart';
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

class _MyApp extends State<MyApp> {
  final CartBloc _cartBloc = CartBloc();
  final CatalogBloc _catalogBloc = CatalogBloc();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<CartBloc>(create: (_) => _cartBloc),
          BlocProvider<CatalogBloc>(create: (_) => _catalogBloc),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          routes: {
            '/': (ctx) => const WelcomeScreen(
                restaurantName: "ISURU", orderTypes: ["PICKUP", "DELIVERY"]),
            '/menu': (ctx) => const MenuPage(),
            '/review': (ctx) => const ReviewOrderContainer(),
            '/item': (ctx) => const ItemSelectContainer(),
          },
          themeMode: ThemeMode.dark,
          darkTheme: ThemeData(
              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.
              brightness: Brightness.dark,
              fontFamily: 'Sarabun',
              primaryColor: Colors.lime,
              shadowColor: Color(0xFF22272e),
              backgroundColor: Color(0xFF1c2128),
              canvasColor: Color(0xFF2d333b),
              dividerColor: Color(0xFF22272e),
              dialogTheme: DialogTheme(backgroundColor: Color(0xFF22272e)),
              elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.lime, onPrimary: Colors.black)),
              textTheme: const TextTheme(
                  headline1: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                      color: Colors.white),
                  headline2: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                  headline3: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                  headline4: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFFadbac7)),
                  headline5: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFFadbac7)),
                  headline6:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  bodyText1: TextStyle(
                      color: Color(0xFFadbac7), fontWeight: FontWeight.w600),
                  bodyText2: TextStyle(color: Color(0xFFadbac7)),
                  subtitle1: TextStyle(
                      color: Color(0xFF768390), fontWeight: FontWeight.bold),
                  subtitle2: TextStyle(color: Color(0xFF768390)))),
          theme: ThemeData(
              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.
              brightness: Brightness.light,
              fontFamily: 'Sarabun',
              primarySwatch: Colors.blue,
              dividerColor: Colors.grey,
              shadowColor: Colors.white,
              backgroundColor: Colors.white,
              canvasColor: Colors.white,
              textTheme: const TextTheme(
                headline1: TextStyle(fontSize: 36, fontWeight: FontWeight.w800),
                headline2: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                headline3: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                headline4: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.black),
                headline5: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                headline6: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                bodyText1: TextStyle(
                    color: Color(0xFFadbac7), fontWeight: FontWeight.w600),
                bodyText2: TextStyle(color: Color(0xFFadbac7)),
                subtitle1: TextStyle(
                    color: Color(0xFF768390), fontWeight: FontWeight.bold),
                subtitle2: TextStyle(color: Color(0xFF768390)),
              )),
          initialRoute: '/',
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
