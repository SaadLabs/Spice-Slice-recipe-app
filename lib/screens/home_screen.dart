import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../models/meal.dart';
import '../services/meal_service.dart';
import '../widgets/recipe_card.dart';
import 'recipe_detail_screen.dart';
import 'dart:io';
import '../services/profile_image_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final MealService _mealService = MealService();

  List<Meal> _todayPicks = [];
  List<Meal> _searchResults = [];

  bool _isLoading = false;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();

    loadTodayPicks();

    ProfileImageService.instance.load();
  }

  Future<void> loadTodayPicks() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final meals = await _mealService.searchMeals("chicken");

      setState(() {
        _todayPicks = meals;
      });
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> searchRecipes(String query) async {
    if (query.trim().isEmpty) {
      setState(() {
        _isSearching = false;
        _searchResults.clear();
      });
      return;
    }

    setState(() {
      _isSearching = true;
      _isLoading = true;
    });

    try {
      final meals = await _mealService.searchMeals(query);

      setState(() {
        _searchResults = meals;
      });
    } catch (e) {
      debugPrint(e.toString());

      setState(() {
        _searchResults = [];
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _goToRecipeDetails(Meal meal) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RecipeDetailScreen(meal: meal)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealsToShow = _isSearching ? _searchResults : _todayPicks;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 29),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header
              Row(
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
                  Material(
                    color: Colors.white,
                    elevation: 2,
                    shape: const CircleBorder(),
                    child: InkWell(
                      onTap: () {},
                      customBorder: const CircleBorder(),
                      child: ValueListenableBuilder<File?>(
                        valueListenable:
                            ProfileImageService.instance.profileImage,
                        builder: (context, image, child) {
                          return CircleAvatar(
                            radius: 26,
                            backgroundColor: AppColors.fireRed,
                            backgroundImage: image != null
                                ? FileImage(image)
                                : null,
                            child: image == null
                                ? const Icon(
                                    Icons.person_outline_rounded,
                                    color: AppColors.textPrimary,
                                  )
                                : null,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              /// Search Bar
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

                      setState(() {
                        _isSearching = false;
                        _searchResults.clear();
                      });
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

              Expanded(
                child: ListView(
                  children: [
                    Text(
                      _isSearching ? "Search Results" : "Today's Picks",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),

                    const SizedBox(height: 18),

                    if (_isLoading)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(40),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    else if (mealsToShow.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 40),
                        child: Center(
                          child: Text(
                            "No recipes found 🍽️",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ),
                      )
                    else
                      ...mealsToShow.map(
                        (meal) => RecipeCard(
                          meal: meal,
                          onTap: () => _goToRecipeDetails(meal),
                        ),
                      ),
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
