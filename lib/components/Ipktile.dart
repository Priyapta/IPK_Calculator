import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class IpkTile extends StatefulWidget {
  const IpkTile({
    super.key,
    required this.judulMatkul,
    required this.nilaiMatkul,
    required this.onTap,
  });
  final String judulMatkul;
  final String nilaiMatkul;
  final Function()? onTap;

  @override
  State<IpkTile> createState() => _IpkTileState();
}

class _IpkTileState extends State<IpkTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          widget.judulMatkul,
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Nilai Mata Kuliah: "),
                        Text(widget.nilaiMatkul),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                Text("1"),
              ],
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}
