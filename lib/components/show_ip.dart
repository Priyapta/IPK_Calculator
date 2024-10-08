import 'package:flutter/material.dart';

class showNilai extends StatefulWidget {
  const showNilai({super.key, required this.nilaiIpk});
  final double nilaiIpk;

  @override
  State<showNilai> createState() => _showNilaiState();
}

class _showNilaiState extends State<showNilai> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        child: Text(widget.nilaiIpk.toString()),
      ),
    );
  }
}
