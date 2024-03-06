class Senjata {
  late String nama;
  late int kekuatan;

  Senjata(this.nama, this.kekuatan);

  String getNama() {
    return this.nama;
  }

  int getKekuatanSerang() {
    return this.kekuatan * 2;
  }
}
