import 'package:flutter/material.dart';

class QuickActionButton extends StatelessWidget {
  final String label;
  final Widget icon;
  const QuickActionButton({super.key, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      color: Colors.white,
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: 30.0, horizontal: 20.0),
        child: Center(
          child: Column(
            children: [
              icon,
              Text(
                label,
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade800),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
