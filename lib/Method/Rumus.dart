void HitungIpk(
  double nilaiMatkul,
  double sks,
) {}

double HitungNilaiMatkul(String  ) {
  return 0;
}

double konversiIpk(double nilaiMatkul) {
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