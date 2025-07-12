import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_supabase_starter/core/validators/text_field_validation.dart';
import 'package:flutter_clean_supabase_starter/feature/authentication/presentation/bloc/auth_bloc.dart';
import 'package:flutter_clean_supabase_starter/shared/components/custom_button.dart';
import 'package:flutter_clean_supabase_starter/shared/components/custom_textfield.dart';
import 'package:flutter_clean_supabase_starter/shared/components/error_banner.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({super.key});

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final passwordController = TextEditingController();
  final cPasswordController = TextEditingController();
  final resetPassFormKey = GlobalKey<FormState>();

  Future<void> _submit() async {
    if (resetPassFormKey.currentState!.validate()) {
      final newPassword = passwordController.text.trim();

      context.read<AuthBloc>().add(
        UpdatePasswordRequested(newPassword: newPassword),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UpdatePasswordSuccess) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Success!", textAlign: TextAlign.center),
              content: const Text(
                "Your password has been successfully updated. You can now log in using your new password.",
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    context.go('/login');
                  },
                  child: const Text("Sign In"),
                ),
              ],
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text("Reset Password"),
            centerTitle: true,
            leading: GestureDetector(
              onTap: () => context.go('/forgot-password'),
              child: const Icon(Icons.arrow_back),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: resetPassFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: state is AuthError
                        ? ErrorBanner(
                            key: ValueKey(state.errorMsg),
                            message: state.errorMsg,
                          )
                        : const SizedBox.shrink(),
                  ),
                  Text(
                    "Enter a strong new password below to complete your password reset.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  CustomTextfield(
                    text: "New Password",
                    isPassword: true,
                    controller: passwordController,
                    validator: emptyPasswordValidation,
                  ),
                  CustomTextfield(
                    text: "Confirm Password",
                    isPassword: true,
                    validator: (value) {
                      return confirmPasswordValidation(
                        value,
                        passwordController,
                      );
                    },
                    controller: cPasswordController,
                  ),
                  CustomButton(text: "Update", btnAction: _submit),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
    cPasswordController.dispose();
  }
}
