import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_supabase_starter/feature/authentication/presentation/bloc/auth_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthBloc>().add(CheckUserSessionRequested());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CheckUserSessionNotFound) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.go('/auth-gate');
            });
          }
          if (state is CheckUserSessionSuccess) {
            return Center(
              child: Text(
                state.user.userMetadata!['full_name'] ?? state.user.email,
              ),
            );
          }

          return Center(child: Text("Checking session...$state"));
        },
      ),
    );
  }
}
