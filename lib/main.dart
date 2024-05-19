import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'MainHomeScreen.dart';
void main() {
  runApp(MaterialScreen());
}

class MaterialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "PlayGame",
      home: MainHomeScreen(),
    );
  }
}
