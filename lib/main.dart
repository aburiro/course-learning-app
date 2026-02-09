import 'package:flutter/material.dart';
import 'firebase/firebase_init.dart';
import 'screens/splash_screen.dart';
import 'screens/welcome_screen.dart';
import "screens/onboarding_screen.dart";
import "screens/login_screen.dart";
import "screens/signup_screen.dart";

import "screens/otp_screen.dart";
import 'screens/dashboard_screen.dart';
import 'screens/classes_screen.dart';
import 'screens/search_screen.dart';
import 'screens/savedcourses_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/userprofilescreen.dart';
import 'screens/progress_screen.dart';
import 'screens/coursedetailscreen.dart';
import 'screens/Course.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseInit.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COURSE-LEARNING-APP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Primary color scheme
        primaryColor: const Color(0xFF4DAF50),
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4DAF50),
          brightness: Brightness.light,
        ),
        // Typography
        fontFamily: 'Poppins',
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: Color(0xFF3C3C3B),
            fontFamily: 'Poppins',
          ),
          displayMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: Color(0xFF3C3C3B),
            fontFamily: 'Poppins',
          ),
          headlineMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xFF3C3C3B),
            fontFamily: 'Poppins',
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF3C3C3B),
            fontFamily: 'Poppins',
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF3C3C3B),
            fontFamily: 'Poppins',
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color(0xFF3C3C3B),
            fontFamily: 'Poppins',
          ),
        ),
        // Button theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4DAF50),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        // Input decoration theme
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFF5F5F5),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE8E7E7)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE8E7E7)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF4DAF50), width: 2),
          ),
          hintStyle: TextStyle(
            color: const Color(0xFF3C3C3B).withOpacity(0.5),
            fontSize: 14,
            fontFamily: 'Poppins',
          ),
        ),
        // App bar theme
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF4DAF50),
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
        // Scaffold background
        scaffoldBackgroundColor: Colors.white,
      ),
      // Routes configuration
      routes: {
        '/': (context) => const SplashScreen(),
        '/onboarding_screen': (context) => const OnboardingScreen(),
        '/login_screen': (context) => const LoginScreen(),
        '/signup_screen': (context) => const SignUpScreen(),

        '/otp_screen': (context) => OTPScreen(),
        '/welcome_screen': (context) => const WelcomeScreen(),
        '/dashboard_screen': (context) => DashboardScreen(),
        '/classes_screen': (context) => const ClassesScreen(),
        '/search_screen': (context) => const SearchScreen(),
        '/savedcourses_screen': (context) => const SavedCoursesScreen(),
        '/profile_screen': (context) => const ProfileScreen(),
        '/userprofile_screen': (context) => const UserProfileScreen(),
        '/progress_screen': (context) => const ProgressScreen(),
        '/coursedetail_screen': (context) => CourseDetailScreen(
              course: Course(
                id: 0,
                title: 'Sample Course',
                instructor: 'Instructor',
                image: 'SC',
                rating: 4.5,
                students: 0,
                price: 0,
                videoId: 'aqz-KE-bpKQ',
                description: 'Sample course description',
              ),
            ),
      },
      initialRoute: '/',
    );
  }
}
