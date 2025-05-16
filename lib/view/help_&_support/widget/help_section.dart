import 'package:flutter/material.dart';

class HelpSection extends StatelessWidget {
  final String title;
  final List<Widget> chidren;
  const HelpSection({
    super.key,
    required this.title,
    required this.chidren,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...chidren,
      ],
    );
  }
}
