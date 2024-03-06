import 'Jubah.dart';
import 'Senjata.dart';

class Jagoan {
  String nama;
  int kesehatanDasar;
  late int kekuatanDasar;
  int derajat;
  late int totalKerusakan = 0;
  int kenaikanKesehatan;
  int kenaikanKekuatan;
  bool hidup;

  // member berupa objek
  late Jubah jubah;
  late Senjata senjata;

  Jagoan(this.nama, this.kesehatanDasar, this.kekuatanDasar, this.derajat, this.kenaikanKekuatan, this.kenaikanKesehatan, this.hidup);

  void setJubah(Jubah jubah) {
    this.jubah = jubah;
  }

  void setSenjata(Senjata senjata) {
    this.senjata = senjata;
  }

  String getNama() {
    return this.nama;
  }

  int sehatMaksimal() {
    return this.kekuatanDasar +
        this.jubah.getTambahKesehatan() +
        this.derajat * this.kenaikanKesehatan;
  }

  int getKekuatanSerangJagoan() {
    return this.kekuatanDasar +
        this.senjata.getKekuatanSerang() +
        this.derajat * this.kenaikanKekuatan;
  }

  int getNilaiKesehatan() {
    return this.sehatMaksimal() - this.totalKerusakan;
  }

  void naikDerajat() {
    this.derajat++;
  }

  bool getStatus() {
    return this.hidup;
  }

  //menyerang lawan
  void menyerang(Jagoan lawan) {
    int kerusakan = this.getKekuatanSerangJagoan();

    print(
        "${this.nama} menyerang ${lawan.getNama()} dengan kekuatan $kerusakan");

    lawan.bertahan(kerusakan);

    this.naikDerajat();
  }

  //bertahan dari lawan
  void bertahan(int kerusakan) {
    int kekuatanBertahan = this.jubah.getNilaiKekuatan();
    int selisihKerusakan;

    print("${this.nama} memiliki kekuatan bertahan: $kekuatanBertahan");

    if (kerusakan > kekuatanBertahan) {
      selisihKerusakan = kerusakan - kekuatanBertahan;
    } else {
      selisihKerusakan = 0;
    }

    print("Kerusakan yang diperoleh $selisihKerusakan\n");

    //tambah total kerusakan
    this.totalKerusakan += selisihKerusakan;

    //periksa apakah jagoan masih hidup?
    if (this.getNilaiKesehatan() <= 0) {
      this.hidup = false;
      this.totalKerusakan = this.sehatMaksimal();
    }

    this.info();
  }

  void info() {
    print("Jagoan\t\t\t\t: ${this.nama}");
    print("Derajat\t\t\t\t: ${this.derajat}");
    print("Kesehatan Dasar\t\t: ${this.kesehatanDasar}");
    print("Kekuatan Dasar\t\t: ${this.kekuatanDasar}");
    print("Kesehatan\t\t\t: ${this.getNilaiKesehatan()}/${this.sehatMaksimal()}");
    print("Kekuatan Maksimal\t\t: ${this.getKekuatanSerangJagoan()}");
    print("Masih hidup?\t\t: ${this.hidup} \n");
  }

  void getNamaJubah() {
    print("Jubah\t\t\t: ${this.jubah.getNama()}");
  }

  void getNamaSenjata() {
    print("Senjata\t\t\t: ${this.senjata.getNama()}");
  }
}
