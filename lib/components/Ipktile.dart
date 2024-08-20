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
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text("semester: "),
                          Text(widget.semester),
                        ],
                      ),
                      Row(
                        children: [
                          Text("SKS: "),
                          Text(widget.sksMatkul),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Nilai Mata Kuliah: "),
                          Text(widget.nilaiMatkul ?? " "),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  Text(
                    widget.index,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: widget.lulus
                  ? Color.fromRGBO(136, 171, 142, 1.000)
                  : Color.fromRGBO(233, 128, 116, 1.000),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ),
    );
  }
}
