import 'package:flutter/material.dart';

class ComponentField extends StatelessWidget {
  const ComponentField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.width});
  final TextEditingController controller;
  final String hintText;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.0),
      child: Container(
        width: width,
        // padding: EdgeInsets.all(5),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            contentPadding:
                EdgeInsets.symmetric(vertical: 1.0, horizontal: 12.0),
          ),
        ),
      ),
    );
  }
}
