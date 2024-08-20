double HitungIpk(
  List<Map<String, dynamic>> list,
) {
  double jumlahSks = 0;
  double nilaiIpk = 0;
  double temporary = 0;
  for (int i = 0; i < list.length; i++) {
    temporary = double.parse(list[i]["sks"]);
    if (list[i]["lulus"]) {
      nilaiIpk += list[i]["nilaiMatkul"] * temporary;
      jumlahSks += temporary;
    }
  }
  return nilaiIpk / jumlahSks;
}

String Expression(double nilai, int length) {
  if (nilai > 3.5) {
    return "Kamu Hebat Tetap Konsisten Terus yaa!!!!";
  } else if (nilai > 3) {
    return "Ayo Masih Bisa Tingkatkan Lagi!!!";
  } else if (nilai > 2.5) {
    return "Jangan Patah Semangat Masih Banyak Harapan";
  } else if (nilai > 2) {
    return "Ini Bukan Akhir Dari Segalanya";
  } else if (length == 0) {
    return "";
  }
  return "Perjalananmu Tidak Berakhir Disini!!!! Jangan Menyerah";
}

double ip(
  List<Map<String, dynamic>> list,
) {
  double jumlahSks = 0;
  double nilaiIpk = 0;
  for (int i = 0; i < list.length; i++) {
    if (list[i]["semester"] == (i + 1).toString()) {
      nilaiIpk += list[i]["nilaiMatkul"] * list[i]["sks"];
      jumlahSks += list[i]["sks"];
    }
  }
  return nilaiIpk / jumlahSks;
}

void addKeys(List<Map<String, dynamic>> list, Map<String, double> myList) {
  for (int i = 0; i < list.length; i++) {
    if (!myList.containsKey(list[i]["semester"])) {
      myList[list[i]["semester"]] = 0;
    }
  }
}

void addValues(List<Map<String, dynamic>> list, Map<String, double> myList) {
  List<String> listKeys = List<String>.from(myList.keys);

  for (int z = 0; z < myList.length; z++) {
    double totalSks = 0;
    double totalNilai = 0;
    var semester = listKeys[z];

    for (int i = 0; i < list.length; i++) {
      if (list[i]["semester"] == semester && list[i]["nilaiMatkul"] != 0) {
        double sks = double.parse(list[i]["sks"]);
        double nilaiMatkul = list[i]["nilaiMatkul"];

        double konversi = sks * konversiBobot(nilaiMatkul);
        totalSks += sks;
        totalNilai += konversi;
      }
    }

    if (myList.containsKey(semester)) {
      myList[semester] = totalSks > 0 ? (totalNilai / totalSks) : 0;
    }
  }
}

bool hasValidData(Map<String, double> data) {
  return data.values.any((value) => value > 0);
}

// void sksSeperate(List<Map<String, dynamic>> list, Map<String, double> myList) {
//   List<String> listKeys = List<String>.from(myList.keys);
//   for (int z = 0; z < myList.length;) {
//     var semester = listKeys[z];

//     int sksTemporary = 0;
//     for (int i = 0; i < list.length; i++) {
//       if (myList.containsKey(list[z]["semester"]) &&
//           list[i]["semester"] == semester) {
//         sksTemporary += int.parse(list[i]["semester"]);
//         myList[semester] = (myList[semester] ?? 0) + nilai;
//         print(myList[semester]);
//       } else {
//         myList[semester] = 0;
//       }
//     }
//   }
// }

double HitungNilaiMatkul(List<String> komponen, List persentase) {
  double nilaiTotal = 0;

  for (int i = 0; i < komponen.length; i++) {
    double nilaiMatkul = double.parse(komponen[i]);
    double persentaseKomponen = double.parse(persentase[i]);
    nilaiTotal += nilaiMatkul * persentaseKomponen / 100;
  }

  return nilaiTotal;
}

double konversiBobot(double nilaiMatkul) {
  if (nilaiMatkul >= 85) {
    return 4.0;
  } else if (nilaiMatkul >= 80) {
    return 3.7;
  } else if (nilaiMatkul >= 75) {
    return 3.3;
  } else if (nilaiMatkul >= 70) {
    return 3.0;
  } else if (nilaiMatkul >= 65) {
    return 2.7;
  } else if (nilaiMatkul >= 60) {
    return 2.3;
  } else if (nilaiMatkul >= 55) {
    return 2.0;
  } else if (nilaiMatkul >= 50) {
    return 1.7;
  } else if (nilaiMatkul >= 45) {
    return 1.3;
  } else if (nilaiMatkul >= 40) {
    return 1.0;
  } else {
    return 0.0;
  }
}

String Index(double nilaiMatkul) {
  if (nilaiMatkul >= 85) {
    return "A";
  } else if (nilaiMatkul >= 80) {
    return "A-";
  } else if (nilaiMatkul >= 75) {
    return "B+";
  } else if (nilaiMatkul >= 70) {
    return "B";
  } else if (nilaiMatkul >= 65) {
    return "B-";
  } else if (nilaiMatkul >= 60) {
    return "C+";
  } else if (nilaiMatkul >= 55) {
    return "C";
  } else if (nilaiMatkul >= 40) {
    return "D";
  } else if (nilaiMatkul >= 0) {
    return "E";
  } else {
    return "i";
  }
}

bool lulus(double nilai) {
  if (nilai >= 55) {
    return true;
  } else {
    return false;
  }
}
