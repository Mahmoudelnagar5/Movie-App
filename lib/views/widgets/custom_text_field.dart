import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.onChanged,
    this.hintText,
    required this.icon, // Added controller parameter
    this.obscureText = false,
    this.onIconPressed,
  });
  final String? hintText;
  final bool obscureText;
  final Function(String)? onChanged;
  final IconData icon;
  final VoidCallback? onIconPressed;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (data) {
        if (data!.isEmpty) {
          return 'Field is required';
        }
        return null;
      },
      obscureText: obscureText,
      onChanged: onChanged,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: onIconPressed,
          color: Colors.grey,
          icon: Icon(icon),
        ), // Wrap icon in Icon widget
        contentPadding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 15,
        ),
        hintText: hintText,

        hintStyle: const TextStyle(
          color: Color(0xff0F335E),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
              10), // Added borderRadius for rounded corners
          borderSide: const BorderSide(
            color: Color(0xff0F335E),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
              10), // Added borderRadius for rounded corners
          borderSide: const BorderSide(
            width: 2,
            color: Color(0xff0F335E),
          ),
        ),
      ),
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Color.fromARGB(255, 17, 4, 75),
      ),
    );
  }
}
