import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/meal.dart';

class MealService {
  static const String baseUrl =
      'https://www.themealdb.com/api/json/v1/1';

  Future<List<Meal>> searchMeals(String query) async {
    final response = await http.get(
      Uri.parse('$baseUrl/search.php?s=$query'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['meals'] == null) {
        return [];
      }

      return (data['meals'] as List)
          .map((meal) => Meal.fromJson(meal))
          .toList();
    } else {
      throw Exception('Failed to load meals');
    }
  }
}