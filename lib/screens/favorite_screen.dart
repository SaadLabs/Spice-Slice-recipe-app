import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../models/meal.dart';
import '../services/favorite_service.dart';
import '../widgets/recipe_card.dart';
import 'recipe_detail_screen.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteService = FavoriteService();

    return Scaffold(
      backgroundColor: AppColors.vanillaCream,
      appBar: AppBar(
        title: const Text("Favorites"),
        centerTitle: true,
        backgroundColor: AppColors.fireRed,
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<List<Meal>>(
        stream: favoriteService.getFavorites(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          final favorites = snapshot.data ?? [];

          if (favorites.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.favorite_border,
                      size: 89,
                      color: AppColors.fireRed,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "No Favorites Yet",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Recipes you mark as favorites will appear here.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final meal = favorites[index];

              return RecipeCard(
                meal: meal,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RecipeDetailScreen(meal: meal),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}