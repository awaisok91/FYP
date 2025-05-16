import 'package:flutter/material.dart';

class RecomendationCard extends StatelessWidget {
  final List<String> recomendation;
  const RecomendationCard({super.key, required this.recomendation});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Recommended Next Steps",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          ...recomendation.map((recommendation) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.lightbulb_outline,
                    size: 20,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                      child: Text(
                    recommendation,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ))
                ],
              ),
            );
          })
        ],
      ),
    );
  }
}
