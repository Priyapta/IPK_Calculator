import 'package:flutter/material.dart';

class textFieldTile extends StatelessWidget {
  const textFieldTile({
    super.key,
    required this.hintText,
    required this.controller,
    required this.obsecureText,
  });
  final String hintText;
  final TextEditingController controller;
  final bool obsecureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obsecureText,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade600,
          ),
        ),
        fillColor: Colors.grey[200],
        filled: true,
        hintText: hintText,
      ),
    );
  }
}
