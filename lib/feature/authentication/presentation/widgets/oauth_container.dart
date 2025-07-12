import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_supabase_starter/feature/authentication/presentation/bloc/auth_bloc.dart';
import 'package:flutter_clean_supabase_starter/feature/authentication/presentation/widgets/oauth_provider.dart';

class OAuthContainer extends StatelessWidget {
  const OAuthContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 28, bottom: 12),
          child: Text(
            "or continue with",
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OAuthProviders(
              signInMethod: "google",
              onTap: () {
                context.read<AuthBloc>().add(GoogleSignInRequested());
              },
            ),
            OAuthProviders(
              signInMethod: "facebook",
              onTap: () {
                context.read<AuthBloc>().add(FacebookSignInRequested());
              },
            ),
          ],
        ),
      ],
    );
  }
}
