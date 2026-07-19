import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/logo/logo.svg',
                    height: 40,
                    width: 40,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
