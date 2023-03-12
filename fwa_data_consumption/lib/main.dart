import 'package:flutter/material.dart';
import 'package:fwa_data_consumption/Code/Router/route_generator.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: true,
      theme: ThemeData(primarySwatch: Colors.red, brightness: Brightness.light),
      darkTheme: ThemeData(
        primarySwatch: Colors.red,
        appBarTheme: const AppBarTheme(color: Colors.red),
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.system,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    ));
