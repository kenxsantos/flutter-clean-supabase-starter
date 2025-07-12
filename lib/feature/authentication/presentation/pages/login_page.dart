import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_supabase_starter/core/validators/text_field_validation.dart';
import 'package:flutter_clean_supabase_starter/feature/authentication/presentation/bloc/auth_bloc.dart';
import 'package:flutter_clean_supabase_starter/feature/authentication/presentation/widgets/forgot_password_container.dart';
import 'package:flutter_clean_supabase_starter/feature/authentication/presentation/widgets/header_container.dart';
import 'package:flutter_clean_supabase_starter/feature/authentication/presentation/widgets/oauth_container.dart';
import 'package:flutter_clean_supabase_starter/shared/components/custom_button.dart';
import 'package:flutter_clean_supabase_starter/shared/components/custom_textfield.dart';
import 'package:flutter_clean_supabase_starter/shared/components/error_banner.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final logInFormKey = GlobalKey<FormState>();

  void _logIn() {
    if (logInFormKey.currentState!.validate()) {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      context.read<AuthBloc>().add(
        UserSignedIn(email: email, password: password),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        if (state is EmailVerificationRequired) {
          context.go('/verify-email/${state.email}');
        }
        if (state is AuthSuccess ||
            state is AuthFacebookSignInSuccess ||
            state is AuthGoogleSignInSuccess) {
          context.go('/auth-gate');
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: logInFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const HeaderContainer(
                    headerText: "Sign In",
                    subText: "Welcome back! You've been missed!",
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: state is AuthError
                        ? ErrorBanner(
                            key: ValueKey(state.errorMsg),
                            message: state.errorMsg,
                          )
                        : const SizedBox.shrink(),
                  ),
                  CustomTextfield(
                    text: "Email",
                    validator: emailValidation,
                    controller: emailController,
                  ),
                  CustomTextfield(
                    text: "Password",
                    isPassword: true,
                    icon: Icons.visibility_off,
                    validator: emptyPasswordValidation,
                    controller: passwordController,
                  ),
                  const ForgotPasswordContainer(),
                  CustomButton(text: "Sign In", btnAction: _logIn),
                  GestureDetector(
                    onTap: () {
                      context.go("/signup");
                      context.read<AuthBloc>().add(AuthReset());
                    },
                    child: Text(
                      "Already have an account? Sign Up",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                  const OAuthContainer(),
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
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
