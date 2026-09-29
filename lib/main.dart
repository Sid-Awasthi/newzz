import 'package:flutter/material.dart';
import 'view/home.dart';

void main() {
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Siddharth News App',
      theme: ThemeData(useMaterial3: true),
      home: const HomePage(),
    );
  }
}
