import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../auth/auth_service.dart';
import '../auth/login_screen.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/profile_image_service.dart';
import 'main_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
await ProfileImageService.instance.save(imageFile);

setState(() {
  _profileImage = imageFile;
});

  Future<void> _removeImage() async {
    await ProfileImageService.instance.remove();

    setState(() {
      _profileImage = null;
    });
  }


  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();

    final user = _authService.currentUser;

    if (user != null) {
      _nameController.text = user.displayName ?? "";
    }

    ProfileImageService.instance.load();
  }

  bool _showPasswordFields = false;

  // Password visibility
  bool _hideCurrentPassword = true;
  bool _hideNewPassword = true;
  bool _hideConfirmPassword = true;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.vanillaCream,
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        backgroundColor: AppColors.fireRed,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: _authService.currentUser != null
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10),

                    GestureDetector(
                      onTap: () async {
                        if (_profileImage == null) {
                          await _pickImage();
                        } else {
                          showModalBottomSheet(
                            context: context,
                            builder: (_) => SafeArea(
                              child: Wrap(
                                children: [
                                  ListTile(
                                    leading: const Icon(Icons.photo),
                                    title: const Text("Change Photo"),
                                    onTap: () async {
                                      Navigator.pop(context);
                                      await _pickImage();
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    title: const Text("Remove Photo"),
                                    onTap: () async {
                                      Navigator.pop(context);
                                      await _removeImage();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: AppColors.fireRed,
                            backgroundImage: _profileImage != null
                                ? FileImage(_profileImage!)
                                : null,
                            child: _profileImage == null
                                ? ValueListenableBuilder<TextEditingValue>(
                                    valueListenable: _nameController,
                                    builder: (context, value, child) {
                                      final name = value.text.trim();

                                      return Text(
                                        name.isEmpty
                                            ? "U"
                                            : name[0].toUpperCase(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    },
                                  )
                                : null,
                          ),

                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              size: 18,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      _authService.currentUser?.email ?? "",
                      style: const TextStyle(color: Colors.grey),
                    ),

                    const SizedBox(height: 30),

                    // Name
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: "Name",
                        hintText: "Enter your name",
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            await _authService.updateName(
                              _nameController.text.trim(),
                            );

                            if (!mounted) return;

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Name updated successfully"),
                              ),
                            );

                            setState(() {});
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())),
                            );
                          }
                        },
                        child: const Text("Save Name"),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // Change Password Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          setState(() {
                            _showPasswordFields = !_showPasswordFields;
                          });
                        },
                        icon: const Icon(Icons.lock_outline),
                        label: Text(
                          _showPasswordFields
                              ? "Cancel Password Change"
                              : "Change Password",
                        ),
                      ),
                    ),

                    if (_showPasswordFields) ...[
                      const SizedBox(height: 20),

                      // Current Password
                      TextField(
                        controller: _currentPasswordController,
                        obscureText: _hideCurrentPassword,
                        decoration: InputDecoration(
                          labelText: "Current Password",
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _hideCurrentPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _hideCurrentPassword = !_hideCurrentPassword;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      // New Password
                      TextField(
                        controller: _newPasswordController,
                        obscureText: _hideNewPassword,
                        decoration: InputDecoration(
                          labelText: "New Password",
                          prefixIcon: const Icon(Icons.lock_reset),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _hideNewPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _hideNewPassword = !_hideNewPassword;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      // Confirm Password
                      TextField(
                        controller: _confirmPasswordController,
                        obscureText: _hideConfirmPassword,
                        decoration: InputDecoration(
                          labelText: "Confirm New Password",
                          prefixIcon: const Icon(Icons.lock_reset),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _hideConfirmPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _hideConfirmPassword = !_hideConfirmPassword;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_newPasswordController.text !=
                                _confirmPasswordController.text) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Passwords do not match"),
                                ),
                              );
                              return;
                            }

                            if (_newPasswordController.text.length < 6) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Password must be at least 6 characters",
                                  ),
                                ),
                              );
                              return;
                            }

                            try {
                              await _authService.changePassword(
                                currentPassword: _currentPasswordController.text
                                    .trim(),
                                newPassword: _newPasswordController.text.trim(),
                              );

                              _currentPasswordController.clear();
                              _newPasswordController.clear();
                              _confirmPasswordController.clear();

                              setState(() {
                                _showPasswordFields = false;
                              });

                              if (!mounted) return;

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Password updated successfully",
                                  ),
                                ),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())),
                              );
                            }
                          },
                          child: const Text("Update Password"),
                        ),
                      ),
                    ],

                    const SizedBox(height: 40),

                    // Logout
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          final logout = await showDialog<bool>(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text("Logout"),
                              content: const Text(
                                "Are you sure you want to logout?",
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                  child: const Text("Cancel"),
                                ),
                                ElevatedButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: const Text("Logout"),
                                ),
                              ],
                            ),
                          );

                          if (logout != true) return;

                          await _authService.signOut();

                          if (!mounted) return;

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const MainScreen(),
                            ),
                            (route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        icon: const Icon(Icons.logout),
                        label: const Text("Logout"),
                      ),
                    ),
                  ],
                ),
              )
            : const Center(
                child: Text(
                  "You are not logged in.",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
      ),
    );
  }
}
