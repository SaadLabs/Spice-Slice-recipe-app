class Meal {
  final String id;
  final String name;
  final String thumbnail;
  final String category;
  final String area;
  final String instructions;
  final String youtube;
  final String source;

  /// Each item contains:
  /// {
  ///   "ingredient": "Chicken",
  ///   "measure": "500g"
  /// }
  final List<Map<String, String>> ingredients;

  Meal({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.category,
    required this.area,
    required this.instructions,
    required this.youtube,
    required this.source,
    required this.ingredients,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    List<Map<String, String>> ingredients = [];

    for (int i = 1; i <= 20; i++) {
      final ingredient =
          (json['strIngredient$i'] ?? '').toString().trim();

      final measure =
          (json['strMeasure$i'] ?? '').toString().trim();

      if (ingredient.isNotEmpty) {
        ingredients.add({
          "ingredient": ingredient,
          "measure": measure,
        });
      }
    }

    return Meal(
      id: json['idMeal'] ?? '',
      name: json['strMeal'] ?? '',
      thumbnail: json['strMealThumb'] ?? '',
      category: json['strCategory'] ?? '',
      area: json['strArea'] ?? '',
      instructions: json['strInstructions'] ?? '',
      youtube: json['strYoutube'] ?? '',
      source: json['strSource'] ?? '',
      ingredients: ingredients,
    );
  }
  factory Meal.fromFirestore(Map<String, dynamic> data) {
  return Meal(
    id: data['id'] ?? '',
    name: data['name'] ?? '',
    thumbnail: data['thumbnail'] ?? '',
    category: data['category'] ?? '',
    area: '',
    instructions: '',
    youtube: '',
    source: '',
    ingredients: [],
  );
}
}