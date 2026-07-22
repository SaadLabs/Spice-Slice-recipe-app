import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class RecipeDetailScreen extends StatelessWidget {
  const RecipeDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Hardcoded data (replace with API later)
    const String mealName = "Chicken Biryani";
    const String category = "Chicken";
    const String area = "Pakistani";

    const String imageUrl =
        "https://images.unsplash.com/photo-1589302168068-964664d93dc0?w=1200";

    final List<Map<String, String>> ingredients = [
      {"ingredient": "Chicken", "measure": "500 g"},
      {"ingredient": "Basmati Rice", "measure": "2 Cups"},
      {"ingredient": "Onion", "measure": "2"},
      {"ingredient": "Tomato", "measure": "2"},
      {"ingredient": "Yogurt", "measure": "1 Cup"},
      {"ingredient": "Ginger Garlic Paste", "measure": "2 tbsp"},
      {"ingredient": "Biryani Masala", "measure": "3 tbsp"},
      {"ingredient": "Fresh Coriander", "measure": "½ Cup"},
    ];

    const String instructions = '''
1. Wash and soak the rice for 30 minutes.

2. Marinate the chicken with yogurt and spices.

3. Fry onions until golden brown.

4. Cook the chicken until tender.

5. Boil the rice until 70% cooked.

6. Layer rice and chicken together.

7. Cook on low heat for 20 minutes.

8. Garnish with coriander and serve hot.
''';

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
                      imageUrl,
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
                        onPressed: () {},
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
                    const Text(
                      mealName,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        const Chip(
                          backgroundColor: AppColors.saffron,
                          label: Text(category),
                        ),
                        const SizedBox(width: 10),
                        const Chip(
                          backgroundColor: AppColors.retroGreen,
                          label: Text(
                            area,
                            style: TextStyle(color: Colors.white),
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
                    ...ingredients.map(
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
                    const Text(
                      instructions,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.7,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 35),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.fireRed,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: () {},
                        icon: const Icon(Icons.play_circle_fill),
                        label: const Text("Watch on YouTube"),
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: () {},
                        icon: const Icon(Icons.public),
                        label: const Text("View Original Recipe"),
                      ),
                    ),
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