import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_supabase_starter/core/validators/text_field_validation.dart';
import 'package:flutter_clean_supabase_starter/feature/authentication/presentation/bloc/auth_bloc.dart';
import 'package:flutter_clean_supabase_starter/shared/components/custom_button.dart';
import 'package:flutter_clean_supabase_starter/shared/components/custom_textfield.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();
  final forgotPasswordFormKey = GlobalKey<FormState>();

  void _submit() {
    if (forgotPasswordFormKey.currentState!.validate()) {
      final email = emailController.text.trim();

      context.read<AuthBloc>().add(ResetPasswordRequested(email: email));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is ResetPasswordRequestSuccess) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text(
                "Reset Link Sent!",
                textAlign: TextAlign.center,
              ),
              content: const Text(
                "We've sent a password reset link to your email. Please check your inbox and follow the instructions to reset your password.",
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Okay"),
                ),
              ],
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text("Forgot Password"),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () => context.go('/login'),
            child: const Icon(Icons.arrow_back),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: forgotPasswordFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Enter your email address below and we'll send you a link to reset your password.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                CustomTextfield(
                  text: "Email",
                  controller: emailController,
                  validator: emailValidation,
                ),
                CustomButton(text: "Submit", btnAction: _submit),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
