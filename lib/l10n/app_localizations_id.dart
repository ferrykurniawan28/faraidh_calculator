// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'Kalkulator Waris Islam';

  @override
  String heirsCount(int count) {
    return '$count orang';
  }

  @override
  String totalAssets(String amount) {
    return 'Total: Rp $amount';
  }

  @override
  String heirPortion(String amount) {
    return 'Bagian: Rp $amount';
  }

  @override
  String get addHeir => 'Tambah Ahli Waris';

  @override
  String get addAsset => 'Tambah Aset';

  @override
  String get calculate => 'Hitung Waris';

  @override
  String get reset => 'Reset Semua';

  @override
  String get settings => 'Pengaturan';

  @override
  String get language => 'Bahasa';

  @override
  String get selectLanguage => 'Pilih Bahasa';

  @override
  String get english => 'English';

  @override
  String get indonesian => 'Bahasa Indonesia';

  @override
  String get heirName => 'Nama Ahli Waris';

  @override
  String get enterFullName => 'Masukkan nama lengkap';

  @override
  String get heirType => 'Jenis Ahli Waris';

  @override
  String get gender => 'Jenis Kelamin';

  @override
  String get male => 'Laki-laki';

  @override
  String get female => 'Perempuan';

  @override
  String get assetName => 'Nama Aset';

  @override
  String get enterAssetName => 'Masukkan nama aset';

  @override
  String get assetType => 'Jenis Aset';

  @override
  String get assetValue => 'Nilai Aset (Rp)';

  @override
  String get enterAssetValue => 'Masukkan nilai aset';

  @override
  String get description => 'Deskripsi (Opsional)';

  @override
  String get addAssetDescription => 'Tambahkan deskripsi aset';

  @override
  String get heirsList => 'Daftar Ahli Waris';

  @override
  String get assetsList => 'Daftar Aset';

  @override
  String get noHeirsYet => 'Belum ada ahli waris yang ditambahkan';

  @override
  String get startByAddingFirstHeir =>
      'Mulai dengan menambahkan ahli waris pertama';

  @override
  String get noAssetsYet => 'Belum ada aset yang ditambahkan';

  @override
  String get startByAddingFirstAsset => 'Mulai dengan menambahkan aset pertama';

  @override
  String get nameCannotBeEmpty => 'Nama tidak boleh kosong';

  @override
  String get assetNameCannotBeEmpty => 'Nama aset tidak boleh kosong';

  @override
  String get assetValueCannotBeEmpty => 'Nilai aset tidak boleh kosong';

  @override
  String get assetValueMustBePositive =>
      'Nilai aset harus berupa angka positif';

  @override
  String get deleteHeir => 'Hapus Ahli Waris';

  @override
  String get deleteAsset => 'Hapus Aset';

  @override
  String areYouSureDeleteHeir(String name) {
    return 'Apakah Anda yakin ingin menghapus $name?';
  }

  @override
  String areYouSureDeleteAsset(String name) {
    return 'Apakah Anda yakin ingin menghapus $name?';
  }

  @override
  String get cancel => 'Batal';

  @override
  String get delete => 'Hapus';

  @override
  String get husband => 'Suami';

  @override
  String get wife => 'Istri';

  @override
  String get father => 'Ayah';

  @override
  String get mother => 'Ibu';

  @override
  String get son => 'Anak Laki-laki';

  @override
  String get daughter => 'Anak Perempuan';

  @override
  String get brother => 'Saudara Laki-laki';

  @override
  String get sister => 'Saudara Perempuan';

  @override
  String get grandfather => 'Kakek';

  @override
  String get grandmother => 'Nenek';

  @override
  String get grandson => 'Cucu Laki-laki';

  @override
  String get granddaughter => 'Cucu Perempuan';

  @override
  String get other => 'Lainnya';

  @override
  String get house => 'Rumah';

  @override
  String get land => 'Tanah';

  @override
  String get car => 'Mobil';

  @override
  String get money => 'Uang';

  @override
  String get gold => 'Emas';

  @override
  String get stocks => 'Saham';

  @override
  String get savings => 'Tabungan';

  @override
  String get islamicInheritance => 'Waris Islam';

  @override
  String get accurateCalculation => 'Perhitungan Akurat';

  @override
  String get easyToUse => 'Mudah Digunakan';

  @override
  String get quickResults => 'Hasil Cepat';

  @override
  String get inheritanceDistribution => 'Distribusi Warisan';

  @override
  String get totalInheritance => 'Total Warisan';

  @override
  String get learnMore => 'Pelajari Lebih Lanjut';

  @override
  String get getStarted => 'Mulai Sekarang';

  @override
  String get poweredBy => 'Didukung oleh';

  @override
  String get developedWith => 'Dikembangkan dengan ❤️ menggunakan Flutter';

  @override
  String get rightsReserved => 'Semua hak dilindungi.';

  @override
  String get about => 'Tentang';

  @override
  String get privacy => 'Privasi';

  @override
  String get terms => 'Syarat';

  @override
  String get contact => 'Kontak';

  @override
  String get noDataToDisplay => 'Tidak ada data untuk ditampilkan';

  @override
  String get noInheritanceCalculation => 'Belum ada perhitungan waris';

  @override
  String get warning => 'Peringatan';

  @override
  String get cannotHaveHusbandAndWife =>
      'Tidak boleh ada suami dan istri bersamaan dalam satu perhitungan waris';

  @override
  String get addAtLeastOneHeir => 'Tambahkan minimal satu ahli waris';

  @override
  String get addAtLeastOneAsset => 'Tambahkan minimal satu aset';

  @override
  String get duplicateHeirNames => 'Terdapat nama ahli waris yang sama';
}
