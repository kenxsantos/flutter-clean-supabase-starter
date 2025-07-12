import 'package:flutter/material.dart';
import 'package:flutter_clean_supabase_starter/shared/components/custom_button.dart';
import 'package:go_router/go_router.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({required this.email, super.key});

  final String email;
  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Email Verification Required"),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.mail_outline, color: Colors.orange, size: 72),
              const SizedBox(height: 24),
              Text(
                "Please Verify Your Email",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              Text(
                "We've sent a confirmation link to your email address. Please check your inbox (or spam folder) and click the link to verify your account.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  widget.email,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),

              CustomButton(
                text: "Sign In",
                btnAction: () => context.go("/login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
