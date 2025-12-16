import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'notification_service.dart';
import 'home_screen.dart';
import 'onboarding_screen.dart';
import 'auth_screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://nzpsrrizoikibdvzpwlq.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im56cHNycml6b2lraWJkdnpwd2xxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQ5Njc4NDgsImV4cCI6MjA4MDU0Mzg0OH0.c32r5ubqAGdUJlaY3rKadydLWjUAWNv74fl6iIzVFtI',
  );

  await NotificationService().initialize();
  runApp(MindControlApp());
}

final supabase = Supabase.instance.client;

class MindControlApp extends StatelessWidget {
  const MindControlApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MindControl',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFFEF626C),
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.quicksandTextTheme(),
        useMaterial3: true,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFEF626C),
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: GoogleFonts.quicksand(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      home: AuthCheckScreen(),
    );
  }
}