import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OAuthProviders extends StatelessWidget {
  const OAuthProviders({
    required this.signInMethod,
    required this.onTap,
    super.key,
  });

  final String signInMethod;
  final VoidCallback onTap;

  String get _iconPath => 'assets/icons/$signInMethod.svg';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(8),
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: const Color(0xFFE5E5E5),
        ),
        child: SvgPicture.asset(
          _iconPath,
          height: 24,
          width: 24,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
