import 'package:flutter/material.dart';

class ComponentField extends StatelessWidget {
  const ComponentField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        fillColor: Colors.grey[200],
      ),
    );
  }
}
