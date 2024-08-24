import 'package:flutter/material.dart';

class MovieDetailsState extends StatelessWidget {
  const MovieDetailsState({
    super.key,
    required this.label,
    required this.value,
  });
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 12,
            fontWeight: FontWeight.bold,
            fontFamily: 'muli',
          ),
        ),
        Text(
          value.toUpperCase(),
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 12,
            fontWeight: FontWeight.bold,
            fontFamily: 'muli',
          ),
        ),
      ],
    );
  }
}
