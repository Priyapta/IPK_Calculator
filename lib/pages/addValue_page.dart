import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ipk_kalkulator/Method/Rumus.dart';
import 'package:ipk_kalkulator/components/DialogBox.dart';
import 'package:ipk_kalkulator/components/component_field.dart';
import 'package:ipk_kalkulator/components/mybutton3.dart';
import 'package:ipk_kalkulator/database/database.dart';

class AddValue extends StatefulWidget {
  const AddValue({
    super.key,
    required this.db,
    required this.index,
  });
  final Tododatabase db;
  final int index;

  @override
  State<AddValue> createState() => _AddValueState();
}

class _AddValueState extends State<AddValue> {
  String a = "";
  List<TextEditingController> componentControllers = [];
  List<TextEditingController> nilaiControllers = [];
  List<TextEditingController> persentaseControllers = [];
  TextEditingController controllerMatkul = TextEditingController();
  String sks = "1";
  String semester = "1";
  late List<String> hintTextMatkul = [];
  late List<String> hintTextNilai = [];
  late List<String> komponen = widget.db.todoList[widget.index]["persentase"];
  late int count;
  double nilaiKomponenSementara = 0;

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

  //jika kontroller tidak dipakai maka langung dihilangkan
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

  void deleteComponent(int index) {
    setState(() {
      widget.db.todoList[widget.index]["komponen"]
          .remove(hintTextMatkul[index]);
      widget.db.todoList[widget.index]["persentase"].removeAt(index);

      componentControllers.removeAt(index);
      nilaiControllers.removeAt(index);
      persentaseControllers.removeAt(index);

      // Kurangi jumlah count
      count--;

      // Perbarui hintTextMatkul dan hintTextNilai
      hintTextMatkul =
          List<String>.from(widget.db.todoList[widget.index]["komponen"].keys);
      hintTextNilai = List<String>.from(
          widget.db.todoList[widget.index]["komponen"].values);

      widget.db.todoList[widget.index]["nilaiMatkul"] = nilaiKomponenSementara;
      widget.db.todoList[widget.index]["index"] = Index(nilaiKomponenSementara);
      widget.db.todoList[widget.index]["lulus"] = lulus(nilaiKomponenSementara);

      // Update database
      widget.db.updateTask();
    });
  }

  void cancel() {
    Navigator.of(context).pop();
  }

  //untuk edit matkul
  void Edit() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            hintText: "Edit Nama Matkul",
            controller: controllerMatkul,
            onSksChanged: (value) {
              setState(() {
                sks = value;
              });
            },
            onSemesterChanged: (value) {
              setState(() {
                semester = value;
              });
            },
            saveTask: editTask,
            cancel: cancel,
          );
        });
  }

  void editTask() {
    setState(() {
      if (controllerMatkul.text.isNotEmpty) {
        widget.db.todoList[widget.index]["matkul"] = controllerMatkul.text;
      }
      widget.db.todoList[widget.index]["sks"] = sks;
      widget.db.todoList[widget.index]["semester"] = semester;

      widget.db.updateTask();

      Navigator.of(context).pop();
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

      // Iterate through the controllers to update the database
      for (int i = 0; i < count; i++) {
        String komponen = componentControllers[i].text.trim();
        String value = nilaiControllers[i].text.trim();
        String percentage = persentaseControllers[i].text.trim();

        if (i < hintTextMatkul.length) {
          if (i < widget.db.todoList[widget.index]["persentase"].length &&
              percentage.isNotEmpty) {
            widget.db.todoList[widget.index]["persentase"][i] = percentage;
          }
          // Jika indeks sesuai dengan panjang daftar, tambahkan nilai baru
          else if (i == widget.db.todoList[widget.index]["persentase"].length) {
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
          if (komponen.isNotEmpty) {
            if (percentage.isNotEmpty) {
              widget.db.todoList[widget.index]["persentase"].add(percentage);
            }
            widget.db.todoList[widget.index]["komponen"]
                [komponen.toLowerCase()] = value;
          }
        }
      }
      //Perhitungan dari index dan nilai matkul
      widget.db.updateTask();
      hintTextNilai = List<String>.from(
          widget.db.todoList[widget.index]["komponen"].values);

      // Hitung dari nilaiMatkul
      nilaiKomponenSementara = HitungNilaiMatkul(
          hintTextNilai, widget.db.todoList[widget.index]["persentase"]);

      widget.db.todoList[widget.index]["nilaiMatkul"] = nilaiKomponenSementara;
      widget.db.todoList[widget.index]["index"] = Index(nilaiKomponenSementara);
      widget.db.todoList[widget.index]["lulus"] = lulus(nilaiKomponenSementara);
      widget.db.updateTask();
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 144, 174, 173),
        title: Center(child: Text("Komponen Nilai")),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ElevatedButton(onPressed: Edit, child: Text("Edit")),
          )
        ],
      ),
      backgroundColor: Color.fromARGB(255, 144, 174, 173),
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
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: Text(
                                    "Matakuliah",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: Text(
                                    "Nilai",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: Text(
                                    "Persentase",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                          Column(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    deleteComponent(index);
                                  },
                                  icon: Icon(Icons.delete))
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: ElevatedButton(onPressed: saveTask, child: Text("Save")),
          ),
        ],
      ),
    );
  }
}
