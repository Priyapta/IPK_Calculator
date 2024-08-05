import 'package:flutter/material.dart';
import 'package:ipk_kalkulator/components/component_field.dart';
import 'package:ipk_kalkulator/database/database.dart';

class AddValue extends StatefulWidget {
  const AddValue(
      {super.key,
      required this.db,
      required this.index,
      required this.namaMatkul});
  final Tododatabase db;
  final int index;
  final String namaMatkul;

  @override
  State<AddValue> createState() => _AddValueState();
}

class _AddValueState extends State<AddValue> {
  List<TextEditingController> componentControllers = [];
  List<TextEditingController> nilaiControllers = [];
  List<TextEditingController> persentaseControllers = [];
  late List<String> hintTextMatkul = [];
  late List<String> hintTextNilai = [];
  late List<String> komponen = widget.db.todoList[widget.index]["persentase"];
  late int count;

  @override
  void initState() {
    super.initState();
    count = widget.db.todoList[widget.index]["komponen"].length;
    hintTextMatkul =
        List<String>.from(widget.db.todoList[widget.index]["komponen"].keys);
    hintTextNilai =
        List<String>.from(widget.db.todoList[widget.index]["komponen"].values);
    // Initialize controllers based on existing components
    for (var i = 0; i < count; i++) {
      componentControllers.add(TextEditingController());
      nilaiControllers.add(TextEditingController());
      persentaseControllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    for (var controller in componentControllers) {
      controller.dispose();
    }
    for (var controller in nilaiControllers) {
      controller.dispose();
    }
    for (var controller in persentaseControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void addComponent() {
    setState(() {
      count++;
      componentControllers.add(TextEditingController());
      nilaiControllers.add(TextEditingController());
      persentaseControllers.add(TextEditingController());
    });
  }

  void savePercetage(int num, int nums, List<String> list, String text) {
    setState(() {
      if (num < nums) {
        widget.db.todoList[widget.index]["persentase"][num] = text;
      } else {
        widget.db.todoList[widget.index]["persentase"].add(text);
      }
    });
  }

  void saveTask() {
    setState(() {
      // Initialize the updated components and percentages

      List<String> updated =
          List<String>.from(widget.db.todoList[widget.index]["persentase"]);

      // Iterate through the controllers to update the database
      for (int i = 0; i < count; i++) {
        String komponen = componentControllers[i].text.trim();
        String value = nilaiControllers[i].text.trim();
        String percentage = persentaseControllers[i].text.trim();

        if (i < hintTextMatkul.length) {
          if (i < widget.db.todoList[widget.index]["persentase"].length) {
            print("a");
            widget.db.todoList[widget.index]["persentase"][i] = percentage;
          } else if (i ==
              widget.db.todoList[widget.index]["persentase"].length) {
            // Jika indeks sesuai dengan panjang daftar, tambahkan nilai baru
            widget.db.todoList[widget.index]["persentase"].add(percentage);
          }
          if (value.isNotEmpty && komponen.isNotEmpty) {
            widget.db.todoList[widget.index]["komponen"]
                [komponen.toLowerCase()] = value;
            widget.db.todoList[widget.index]["komponen"]
                .remove(hintTextMatkul[i]);
          }
          //Edit Nilai saja dari matkul diinginkan
          else if (value.isNotEmpty) {
            widget.db.todoList[widget.index]["komponen"][hintTextMatkul[i]] =
                value;
          }
          //Jika komponen nilai dan matkul terisi
        } else {
          if (percentage.isNotEmpty && i < hintTextMatkul.length) {
            print("c");
            widget.db.todoList[widget.index]["persentase"].add(percentage);
          }
          if (komponen.isNotEmpty) {
            widget.db.todoList[widget.index]["komponen"]
                [komponen.toLowerCase()] = value;
          }

          // else if (komponen.isEmpty && value.isNotEmpty) {
          //     widget.db.todoList[widget.index]["komponen"][hintTextMatkul[i]] = value;
          // }
        }
      }
      widget.db.updateTask();

      // Update the database with the new components and percentages

      // Save the changes to the database

      // Debug prints to check the results

      widget.db.updateTask();
      print(widget.db.todoList[widget.index]["komponen"]);
      print(widget.db.todoList[widget.index]["persentase"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: addComponent,
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: count,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Text(
                                  "Nama Matakuliah",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              ComponentField(
                                width: screenWidth / 2,
                                controller: componentControllers[index],
                                hintText: (index < hintTextMatkul.length &&
                                        hintTextMatkul[index].isNotEmpty)
                                    ? hintTextMatkul[index]
                                    : " ",
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Text(
                                  "Nilai",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              ComponentField(
                                width: screenWidth / 4,
                                controller: nilaiControllers[index],
                                hintText: (index < hintTextNilai.length &&
                                        hintTextNilai[index].isNotEmpty)
                                    ? hintTextNilai[index]
                                    : " ",
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Text(
                                  "Persentase",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              ComponentField(
                                width: screenWidth / 6,
                                controller: persentaseControllers[index],
                                hintText: (index <
                                        widget
                                            .db
                                            .todoList[widget.index]
                                                ["persentase"]
                                            .length)
                                    ? widget.db.todoList[widget.index]
                                        ["persentase"][index]
                                    : " ",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
          ElevatedButton(onPressed: saveTask, child: Text("Save")),
        ],
      ),
    );
  }
}
