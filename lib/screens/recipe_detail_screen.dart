import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../models/meal.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/utils/launcher.dart';
import '../services/favorite_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth/login_screen.dart';
import '../services/interstitial_ad_service.dart';

class RecipeDetailScreen extends StatefulWidget {
  final Meal meal;

  const RecipeDetailScreen({super.key, required this.meal});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  final FavoriteService _favoriteService = FavoriteService();
  final InterstitialAdService _interstitialAdService = InterstitialAdService();

  bool _isFavorite = false;
  @override
  void dispose() {
    _interstitialAdService.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (FirebaseAuth.instance.currentUser != null) {
      _loadFavorite();
    }
    _interstitialAdService.loadAd();
  }

  Future<void> _loadFavorite() async {
    _isFavorite = await _favoriteService.isFavorite(widget.meal.id);

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _toggleFavorite() async {
    if (FirebaseAuth.instance.currentUser == null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
      return;
    }

    if (_isFavorite) {
      await _favoriteService.removeFavorite(widget.meal.id);

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Removed from favorites")));
      }
    } else {
      await _favoriteService.addFavorite(widget.meal);

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Added to favorites")));
      }
    }

    if (mounted) {
      setState(() {
        _isFavorite = !_isFavorite;
      });
    }
  }

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
                      widget.meal.thumbnail,
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
                        onPressed: () {
                          _interstitialAdService.showAd();
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),

                  Positioned(
                    top: 16,
                    right: 16,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: Icon(
                          _isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: AppColors.fireRed,
                        ),
                        onPressed: _toggleFavorite,
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
                      widget.meal.name,
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
                          label: Text(widget.meal.category),
                        ),

                        Chip(
                          backgroundColor: AppColors.retroGreen,
                          label: Text(
                            widget.meal.area,
                            style: const TextStyle(color: Colors.white),
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

                    ...widget.meal.ingredients.map(
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
                            style: const TextStyle(fontWeight: FontWeight.bold),
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
                      widget.meal.instructions,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.7,
                        color: AppColors.textSecondary,
                      ),
                    ),

                    const SizedBox(height: 35),

                    if (widget.meal.youtube.isNotEmpty)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.fireRed,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          onPressed: () => launchURL(widget.meal.youtube),
                          icon: const Icon(Icons.play_circle_fill),
                          label: const Text("Watch on YouTube"),
                        ),
                      ),

                    if (widget.meal.source.isNotEmpty) ...[
                      const SizedBox(height: 15),

                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          onPressed: () => launchURL(widget.meal.source),
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
