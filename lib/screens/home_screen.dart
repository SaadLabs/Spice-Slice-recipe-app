import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../widgets/recipe_card.dart';
// Note: Adjust this import path depending on where your file is located!
import 'recipe_detail_screen.dart'; 

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  Future<void> searchRecipes(String query) async {
    if (query.trim().isEmpty) return;

    print("Searching: $query");

    // TODO:
    // Call your MealDB API here.
    // Example:
    // final meals = await MealDbService.searchMeals(query);
    // setState(() {
    //   _meals = meals;
    // });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Navigation helper to go to the details screen
  void _goToRecipeDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RecipeDetailScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Hello",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Find your next favorite\nrecipe.",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            height: 1.15,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Material(
                    color: Colors.white,
                    elevation: 2,
                    shape: const CircleBorder(),
                    child: InkWell(
                      onTap: () {},
                      customBorder: const CircleBorder(),
                      child: const Padding(
                        padding: EdgeInsets.all(14),
                        child: Icon(
                          Icons.person_outline_rounded,
                          size: 24,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Search Bar
              TextField(
                controller: _searchController,
                textInputAction: TextInputAction.search,
                onSubmitted: searchRecipes,
                decoration: InputDecoration(
                  hintText: "Search recipes...",
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                    },
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 18),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // Results
              Expanded(
                child: ListView(
                  // We removed "const" here so the RecipeCards can use the onTap function
                  children: [
                    const Text(
                      "Today's Picks",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 18),
                    
                    // Passing the navigation helper to each card
                    RecipeCard(onTap: _goToRecipeDetails),
                    RecipeCard(onTap: _goToRecipeDetails),
                    RecipeCard(onTap: _goToRecipeDetails),
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