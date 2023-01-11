import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/cart.dart';
import 'package:flutter_application_1/providers/provider.dart';
import 'package:flutter_application_1/screens/add_product.dart';
import 'package:flutter_application_1/screens/cart_screen.dart';
import 'package:flutter_application_1/screens/edit_screen.dart';
import 'package:flutter_application_1/screens/order_screen.dart';
import 'package:flutter_application_1/screens/product_details.dart';
import 'package:flutter_application_1/screens/product_overview.dart';
import 'package:flutter_application_1/screens/userProduct.dart';
import 'package:provider/provider.dart';
import 'models/order.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey _widgetKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    void didChangeDependencies() {
      context.dependOnInheritedWidgetOfExactType(aspect: _widgetKey);
    }
    //if the app is rebuilt with null values fix with globalkey and notify with didChangeDependencies
    @override
    void initState() {
      didChangeDependencies();
      super.initState();
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ProductProvider()),
        ChangeNotifierProvider.value(value: Cart()),
        ChangeNotifierProvider.value(value: Order())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Payment Demo',
        theme: ThemeData(
            fontFamily: "Roboto",
            primaryColor: Colors.white,
            primaryColorDark: Colors.black,
            primaryColorLight: Colors.greenAccent,
            iconTheme: const IconThemeData(color: Colors.white, size: 20),
            textTheme: const TextTheme(
              headline1: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Playfair',
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
              headline2: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
              bodyText1: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
              headline3: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Playfair',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              headline4: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Playfair',
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              bodyText2: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.black, size: 24))),
        home: MyHome(
          key: _widgetKey,
        ),
        routes: {
          AddProduct.addRoute:(context) => AddProduct(),
          UserProduct.routeName:(context) => UserProduct(),
          PackageDetails.RouteName: (context) => const PackageDetails(),
          CartScreen.routeName: (context) => const CartScreen(),
          OrderScreen.orderRouteName: (context) => OrderScreen()
        },
      ),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (p0, p1) => Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ProductOverView()),
    );
  }
}
