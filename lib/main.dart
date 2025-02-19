import 'package:flutter/material.dart';
import 'package:my_auracode_app/features/auth/presentation/pages/signup_page.dart';
import 'core/theme/app_theme.dart';
import 'features/home/presentation/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SignupPage(),
      theme: AppTheme.lightTheme,
    );
  }
}
