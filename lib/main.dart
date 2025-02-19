import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_auracode_app/features/auth/presentation/pages/signup_page.dart';
import 'package:my_auracode_app/firebase_options.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
