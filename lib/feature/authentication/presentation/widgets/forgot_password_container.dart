import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordContainer extends StatelessWidget {
  const ForgotPasswordContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
          child: GestureDetector(
            onTap: () => context.go('/forgot-password'),
            child: Text(
              "Forgot Password?",
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ),
        ),
      ],
    );
  }
}
