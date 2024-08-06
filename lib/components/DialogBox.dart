import 'package:flutter/material.dart';
import 'package:ipk_kalkulator/components/dropdown.dart';
import 'package:ipk_kalkulator/components/my_button.dart';
import 'package:ipk_kalkulator/components/my_button2.dart';

class DialogBox extends StatefulWidget {
  const DialogBox({
    super.key,
    required this.controller,
    required this.onSksChanged,
    required this.onSemesterChanged,
    required this.saveTask,
    required this.cancel,
  });
  final TextEditingController controller;
  final ValueChanged<String> onSksChanged;
  final ValueChanged<String> onSemesterChanged;
  final VoidCallback saveTask;
  final VoidCallback cancel;

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;
    return AlertDialog(
      backgroundColor: Colors.grey[400],
      content: Container(
        height: screenHeight / 4,
        width: screenWidth / 8,
        child: Column(
          children: [
            TextField(
              controller: widget.controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Input Nama Matkul",
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("SKS",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      DropDown(
                        items: ["1", "2", "3", "4", "5"],
                        onChanged: widget.onSksChanged,
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Semester",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      DropDown(
                        items: ["1", "2", "3", "4", "5", "6", "7", "8", "9"],
                        onChanged: widget.onSemesterChanged,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: DialogButton(text: "Cancel", onTap: widget.cancel),
                ),
                DialogButton(text: "Save", onTap: widget.saveTask),
              ],
            )
          ],
        ),
      ),
    );
  }
}
