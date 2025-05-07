import 'package:flutter/material.dart';

class OverViewCardWidget extends StatelessWidget {
  final String instructorId;
  const OverViewCardWidget({super.key, required this.instructorId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize:
            MainAxisSize.min, // Prevents the Column from expanding infinitely
        children: [
          const Text(
            "Overview",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.2,
            shrinkWrap:
                true, // Ensures the GridView takes only the required space
            physics:
                const NeverScrollableScrollPhysics(), // Disables GridView scrolling
            children: [
              _buildCard("Total Students", "120", Icons.people),
              _buildCard("Active Courses", "8", Icons.school),
              _buildCard("Total Revenue", "\$5000", Icons.attach_money),
              _buildCard("Avg. Rating", "4.5", Icons.star),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.blue,
            size: 40,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
