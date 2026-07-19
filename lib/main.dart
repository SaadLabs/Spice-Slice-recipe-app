import 'package:flutter/material.dart';
import 'core/constants/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spice&Slice',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.vanillaCream,
      ),
      home: const ColorTestScreen(),
    );
  }
}

class ColorTestScreen extends StatelessWidget {
  const ColorTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.vanillaCream,

      appBar: AppBar(
        title: const Text(
          "Spice&Slice",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.vanillaCream,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [

            const Text(
              "Brand Colors",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.russet,
              ),
            ),

            const SizedBox(height: 20),

            _colorTile("Fire Red", AppColors.fireRed),
            _colorTile("Retro Green", AppColors.retroGreen),
            _colorTile("Vanilla Cream", AppColors.vanillaCream),
            _colorTile("Saffron", AppColors.saffron),
            _colorTile("Russet", AppColors.russet),

            const SizedBox(height: 30),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.fireRed,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {},
              child: const Text("Primary Button"),
            ),

            const SizedBox(height: 15),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.retroGreen,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {},
              child: const Text("Secondary Button"),
            ),

            const SizedBox(height: 25),

            Card(
              color: Colors.white,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Chicken Karahi",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.russet,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "A traditional Pakistani recipe with rich spices.",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [

                Chip(
                  label: const Text("Spicy"),
                  backgroundColor: AppColors.fireRed,
                  labelStyle: const TextStyle(color: Colors.white),
                ),

                Chip(
                  label: const Text("Healthy"),
                  backgroundColor: AppColors.retroGreen,
                  labelStyle: const TextStyle(color: Colors.white),
                ),

                Chip(
                  label: const Text("Featured"),
                  backgroundColor: AppColors.saffron,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget _colorTile(String name, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [

          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
            ),
          ),

          const SizedBox(width: 15),

          Text(
            name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}