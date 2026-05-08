import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFFFF6B6B);
  static const background = Color(0xFFF9FAFB);
  static const textPrimary = Color(0xFF111827);
  static const textSecondary = Color(0xFF6B7280);
}

class AppTextStyles {
  static const title = TextStyle(
    fontSize: 16, fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );
  static const subtitle = TextStyle(
    fontSize: 13, color: AppColors.textSecondary,
  );
}