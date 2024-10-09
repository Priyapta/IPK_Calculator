import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class IpkTile extends StatefulWidget {
  const IpkTile({
    super.key,
    required this.judulMatkul,
    required this.nilaiMatkul,
    required this.sksMatkul,
    required this.index,
    required this.semester,
    required this.lulus,
    required this.onTap,
    required this.deleteFunction,
  });
  final String judulMatkul;
  final String nilaiMatkul;
  final String sksMatkul;
  final String index;
  final bool lulus;
  final String semester;
  final Function(BuildContext)? deleteFunction;
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
        child: Slidable(
          endActionPane: ActionPane(
            motion: StretchMotion(),
            children: [
              SlidableAction(
                onPressed: widget.deleteFunction,
                icon: Icons.delete,
                backgroundColor: Colors.red,
              )
            ],
          ),
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
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text("semester: ",
                              style: TextStyle(color: Colors.black)),
                          Text(widget.semester,
                              style: TextStyle(color: Colors.black)),
                        ],
                      ),
                      Row(
                        children: [
                          Text("SKS: ", style: TextStyle(color: Colors.black)),
                          Text(widget.sksMatkul,
                              style: TextStyle(color: Colors.black)),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Nilai Mata Kuliah: ",
                            style: TextStyle(color: Colors.black),
                          ),
                          Text(widget.nilaiMatkul ?? " ",
                              style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  Text(
                    widget.index,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: widget.lulus
                  ? Color(0xFF88AB8E)
                  : const Color.fromARGB(255, 234, 107, 88),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ),
    );
  }
}
