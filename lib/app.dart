import 'package:flutter/material.dart';
import 'widgets/bottom_nav_bar.dart';
import 'utils/constants.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social Commerce',
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        fontFamily: 'Arial',
      ),
      home: const MainNavBar(),
    );
  }
}