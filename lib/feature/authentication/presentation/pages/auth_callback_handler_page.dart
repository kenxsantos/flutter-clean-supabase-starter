import 'package:flutter/material.dart';
import 'package:app_links/app_links.dart';
import 'package:go_router/go_router.dart';

class AuthCallbackHandlerPage extends StatefulWidget {
  const AuthCallbackHandlerPage({super.key});

  @override
  State<AuthCallbackHandlerPage> createState() =>
      _AuthCallbackHandlerPageState();
}

class _AuthCallbackHandlerPageState extends State<AuthCallbackHandlerPage> {
  @override
  void initState() {
    super.initState();
    _handleDeepLink();
  }

  Future<void> _handleDeepLink() async {
    final uri = await AppLinks().getInitialLink();

    final type = uri?.queryParameters['type'];

    if (uri == null) {
      context.go('/auth-gate');
    } else {
      if (type == 'recovery') {
        context.go('/reset-password-form');
      } else {
        context.go('/auth-gate');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
