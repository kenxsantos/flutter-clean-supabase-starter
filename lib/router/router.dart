import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_supabase_starter/core/notifier/go_router_refresh_notifier.dart';
import 'package:flutter_clean_supabase_starter/core/services/auth_gate.dart';
import 'package:flutter_clean_supabase_starter/feature/authentication/presentation/pages/auth_callback_handler_page.dart';
import 'package:flutter_clean_supabase_starter/feature/authentication/presentation/pages/forgot_password_page.dart';
import 'package:flutter_clean_supabase_starter/feature/authentication/presentation/pages/login_page.dart';
import 'package:flutter_clean_supabase_starter/feature/authentication/presentation/pages/register_page.dart';
import 'package:flutter_clean_supabase_starter/feature/authentication/presentation/pages/reset_password_form.dart';
import 'package:flutter_clean_supabase_starter/feature/authentication/presentation/pages/verify_email_page.dart';
import 'package:flutter_clean_supabase_starter/feature/homepage/presentation/pages/home_page.dart';
import 'package:flutter_clean_supabase_starter/feature/landing/app_entry.dart';
import 'package:flutter_clean_supabase_starter/feature/landing/landing_page.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppRouter {
  late final GoRouter router;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  AppRouter() {
    router = GoRouter(
      navigatorKey: navigatorKey,
      initialLocation: '/',
      refreshListenable: GoRouterRefreshNotifier(
        Supabase.instance.client.auth.onAuthStateChange,
      ),

      routes: [
        GoRoute(
          path: '/',
          name: 'entry',
          builder: (context, state) => const AppEntryPoint(),
        ),
        GoRoute(
          path: '/landing',
          name: 'landing',
          builder: (context, state) => const LandingPage(),
        ),

        GoRoute(
          path: '/auth-gate',
          name: 'auth-gate',
          builder: (context, state) => const AuthGate(),
        ),
        GoRoute(
          path: '/login',
          name: 'login',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: '/signup',
          name: 'signup',
          builder: (context, state) => const RegisterPage(),
        ),
        GoRoute(
          path: '/home',
          name: 'home',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/verify-email/:email',
          name: 'verify-email',
          builder: (context, state) =>
              VerifyEmailPage(email: state.pathParameters['email'] ?? ''),
        ),
        GoRoute(
          path: '/forgot-password',
          name: 'forgot-password',
          builder: (context, state) => const ForgotPasswordPage(),
        ),
        GoRoute(
          path: '/reset-password-form',
          name: 'reset-password-form',
          builder: (context, state) => const ResetPasswordForm(),
        ),
        GoRoute(
          path: '/auth/callback',
          name: 'auth-callback',
          builder: (context, state) => const AuthCallbackHandlerPage(),
        ),
      ],
    );
  }
}
