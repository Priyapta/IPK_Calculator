void HitungIpk(
  double nilaiMatkul,
  double sks,
) {}

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
