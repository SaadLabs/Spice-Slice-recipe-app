import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/meal.dart';

class FavoriteService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get _uid => _auth.currentUser!.uid;

  CollectionReference get _favorites =>
      _firestore.collection('users').doc(_uid).collection('favorites');

  Future<void> addFavorite(Meal meal) async {
    await _favorites.doc(meal.id).set({
      'id': meal.id,
      'name': meal.name,
      'category': meal.category,
      'thumbnail': meal.thumbnail,
    });
  }

  Future<void> removeFavorite(String mealId) async {
    await _favorites.doc(mealId).delete();
  }

  Future<bool> isFavorite(String mealId) async {
    return (await _favorites.doc(mealId).get()).exists;
  }

  Stream<List<Meal>> getFavorites() {
    return _favorites.snapshots().map(
      (snapshot) => snapshot.docs
          .map((doc) => Meal.fromFirestore(doc.data() as Map<String, dynamic>))
          .toList(),
    );
  }
}