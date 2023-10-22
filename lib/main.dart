import 'package:flutter/material.dart';
import 'package:todolist_app/login.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(elevation: 0),
        useMaterial3: true,
      ),
      home: LoginPage(), // Start with the login page
      debugShowCheckedModeBanner: false,
    ),
  );
}
