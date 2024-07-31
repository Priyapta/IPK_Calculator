import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ipk_kalkulator/pages/main_page.dart';

class customButton extends StatelessWidget {
  const customButton({super.key, required this.onPressed, required this.text});
  final VoidCallback onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
