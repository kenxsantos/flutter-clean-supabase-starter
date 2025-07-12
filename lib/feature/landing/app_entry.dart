import 'package:flutter/material.dart';
import 'package:flutter_clean_supabase_starter/feature/authentication/presentation/pages/auth_callback_handler_page.dart';
import 'package:flutter_clean_supabase_starter/feature/homepage/presentation/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'landing_page.dart';

class AppEntryPoint extends StatelessWidget {
  const AppEntryPoint({super.key});

  Future<Widget> _decidePage() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;
    final session = Supabase.instance.client.auth.currentSession;

    if (isFirstLaunch) {
      await prefs.setBool('isFirstLaunch', false);
      return const LandingPage();
    } else if (session != null) {
      return const HomePage();
    } else {
      return const AuthCallbackHandlerPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _decidePage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return snapshot.data!;
      },
    );
  }
}
