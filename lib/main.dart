import 'package:flutter/material.dart';

void main() {
  runApp(const RecipeApp());
}

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipe Finder',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Recipe Finder'),
        ),
        body: const Center(
          child: Text('Welcome to Recipe Finder'),
        ),
      ),
    );
  }
}