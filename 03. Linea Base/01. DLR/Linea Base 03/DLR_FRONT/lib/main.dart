import 'package:dealer/constats.dart';
import 'package:dealer/route_generator.dart';
import 'package:flutter/material.dart';

void main() => runApp(app());

class app extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Dealer",
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}



