import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileImageService {
  ProfileImageService._();

  static final ProfileImageService instance = ProfileImageService._();

  final ValueNotifier<File?> profileImage = ValueNotifier<File?>(null);

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final path = prefs.getString('profile_image');

    if (path != null && File(path).existsSync()) {
      profileImage.value = File(path);
    } else {
      profileImage.value = null;
    }
  }

  Future<void> save(File image) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      'profile_image',
      image.path,
    );

    profileImage.value = image;
  }

  Future<void> remove() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('profile_image');

    profileImage.value = null;
  }
}