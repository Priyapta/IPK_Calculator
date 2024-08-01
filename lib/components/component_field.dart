import 'package:flutter/material.dart';

class ComponentField extends StatelessWidget {
  const ComponentField({super.key, required this.controller,required this.hintText});
  final TextEditingController controller;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.0),
      child: Container(
        width: screenWidth / 4,
        padding: EdgeInsets.all(12),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
              hintText: hintText,
              enabledBorder: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder()),
        ),
      ),
    );
  }
}
