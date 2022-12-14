import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/cart.dart';
import 'package:flutter_application_1/providers/provider.dart';
import 'package:flutter_application_1/screens/cart_screen.dart';
import 'package:flutter_application_1/screens/order_screen.dart';
import 'package:flutter_application_1/screens/product_details.dart';
import 'package:flutter_application_1/screens/product_overview.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';

import 'models/order.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final key = GlobalKey();
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
        home: ProductOverView(
          key: key,
        ),
        routes: {
          PackageDetails.RouteName: (context) => PackageDetails(),
          CartScreen.routeName: (context) => CartScreen(),
          OrderScreen.orderRouteName: (context) => OrderScreen()
        },
      ),
    );
  }
}
