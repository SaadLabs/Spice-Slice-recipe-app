import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../models/meal.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/utils/launcher.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Meal meal;

  const RecipeDetailScreen({
    super.key,
    required this.meal,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.vanillaCream,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    ),
                    child: Image.network(
                      meal.thumbnail,
                      height: 280,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  Positioned(
                    top: 16,
                    left: 16,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 16,
                    right: 16,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: const Icon(
                          Icons.favorite_border,
                          color: AppColors.fireRed,
                        ),
                        onPressed: () {
                          // TODO: Add favorites
                        },
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      meal.name,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Wrap(
                      spacing: 10,
                      children: [
                        Chip(
                          backgroundColor: AppColors.saffron,
                          label: Text(meal.category),
                        ),

                        Chip(
                          backgroundColor: AppColors.retroGreen,
                          label: Text(
                            meal.area,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    const Text(
                      "Ingredients",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.fireRed,
                      ),
                    ),

                    const SizedBox(height: 15),

                    ...meal.ingredients.map(
                      (item) => Card(
                        elevation: 2,
                        margin: const EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          leading: const Icon(
                            Icons.restaurant_menu,
                            color: AppColors.fireRed,
                          ),
                          title: Text(item["ingredient"]!),
                          trailing: Text(
                            item["measure"]!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    const Text(
                      "Instructions",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.fireRed,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Text(
                      meal.instructions,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.7,
                        color: AppColors.textSecondary,
                      ),
                    ),

                    const SizedBox(height: 35),

                    if (meal.youtube.isNotEmpty)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.fireRed,
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                            ),
                          ),
                          onPressed: () => _launchUrl(meal.youtube),
                          icon: const Icon(Icons.play_circle_fill),
                          label: const Text("Watch on YouTube"),
                        ),
                      ),

                    if (meal.source.isNotEmpty) ...[
                      const SizedBox(height: 15),

                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                            ),
                          ),
                          onPressed: () => _launchUrl(meal.source),
                          icon: const Icon(Icons.public),
                          label: const Text("View Original Recipe"),
                        ),
                      ),
                    ],

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}