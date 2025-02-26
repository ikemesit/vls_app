import 'package:flutter/material.dart';

class ContentTypeSelector extends StatelessWidget {
  final bool isSelected;
  final String label;
  const ContentTypeSelector(
      {super.key, required this.isSelected, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(0),
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 2.0),
      decoration: BoxDecoration(
          color: isSelected ? Colors.green : Colors.white,
          borderRadius: BorderRadius.circular(25.0),
          border: Border.fromBorderSide(
              BorderSide(color: Colors.green, width: 1.0))
          ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
              fontSize: 12.0,
              color: isSelected ? Colors.white : Colors.green,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
