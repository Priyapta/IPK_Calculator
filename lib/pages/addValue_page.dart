import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

  void saveTask() {
    setState(() {
      setState(() {
        Map<String, String> updatedComponents = {};
        for (int i = 0; i < count; i++) {
          if (componentControllers[i].text.isNotEmpty) {
            updatedComponents[componentControllers[i].text.toLowerCase()] =
                nilaiControllers[i].text;
            widget.db.todoList[widget.index]["komponen"] = updatedComponents;
          } else if (widget.db.todoList[widget.index]["komponen"]
                  [hintTextMatkul[i].isNotEmpty] &&
              nilaiControllers[i].text.isEmpty) {
            widget.db.todoList[widget.index]["komponen"][hintTextMatkul[i]] =
                nilaiControllers[i].text;
          }
        }

        widget.db.updateTask();
        print(widget.db.todoList[widget.index]["komponen"]["w"]);
      });
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text(
                            "Nama Mata Kuliah",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ComponentField(
                          width: screenWidth / 2,
                          controller: componentControllers[index],
                          hintText: (index < hintTextMatkul.length &&
                                  hintTextMatkul[index].isNotEmpty)
                              ? hintTextMatkul[index]
                              : " ",
                        ),
                        ComponentField(
                          width: screenWidth / 4,
                          controller: nilaiControllers[index],
                          hintText: (index < hintTextMatkul.length &&
                                  hintTextNilai[index].isNotEmpty)
                              ? hintTextNilai[index]
                              : " ",
                        ),
                        // ComponentField(
                        //   controller: persentaseControllers[index],
                        //   hintText: "Masukan Persentase Komponen",
                        // ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
          ElevatedButton(onPressed: saveTask, child: Text("save")),
        ],
      ),
    );
  }
}
