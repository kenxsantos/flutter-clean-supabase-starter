import 'package:flutter/material.dart';

class HeaderContainer extends StatelessWidget {
  const HeaderContainer({
    required this.headerText,
    required this.subText,
    super.key,
  });

  final String headerText;
  final String subText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          Text(headerText, style: Theme.of(context).textTheme.displayMedium),
          Text(subText, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}
