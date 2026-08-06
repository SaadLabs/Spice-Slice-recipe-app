import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileImageService {
  ProfileImageService._();

  String? get _key {
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) return null;

  return 'profile_image_${user.uid}';
}

  static final ProfileImageService instance = ProfileImageService._();

  final ValueNotifier<File?> profileImage = ValueNotifier<File?>(null);

Future<void> load() async {
  final key = _key;

  if (key == null) {
    profileImage.value = null;
    return;
  }

  final prefs = await SharedPreferences.getInstance();
  final path = prefs.getString(key);

  if (path != null && File(path).existsSync()) {
    profileImage.value = File(path);
  } else {
    profileImage.value = null;
  }
}

Future<void> save(File image) async {
  final key = _key;

  if (key == null) return;

  final prefs = await SharedPreferences.getInstance();

  await prefs.setString(key, image.path);

  profileImage.value = image;
}

Future<void> remove() async {
  final key = _key;

  if (key == null) return;

  final prefs = await SharedPreferences.getInstance();

  await prefs.remove(key);

  profileImage.value = null;
}
void clearMemory() {
  profileImage.value = null;
}
}