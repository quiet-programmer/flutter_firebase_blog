import 'package:firebase_blog_app/screens/add_screen.dart';
import 'package:firebase_blog_app/screens/home.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Firebase Blog App",
      theme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(
          elevation: 0.0,
          textTheme: TextTheme(
            headline6: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
        ),
      ),
      home: Home(),
    );
  }
}
