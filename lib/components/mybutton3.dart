import 'package:flutter/material.dart';

class buttonAppBar extends StatelessWidget {
  const buttonAppBar({super.key, required this.text, required this.onTap});
  final String text;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
        decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
            child: Text(
          text,
          style: TextStyle(
              color: Colors.grey[800],
              fontWeight: FontWeight.bold,
              fontSize: 16),
        )),
      ),
    );
  }
}
