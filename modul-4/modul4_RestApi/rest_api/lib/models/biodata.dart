class Biodata {
  final String id;
  final String nama;
  final String jenisKelamin;
  final String alamat;

  Biodata({
    required this.id,
    required this.nama,
    required this.jenisKelamin,
    required this.alamat,
  });

  factory Biodata.fromJson(Map<String, dynamic> json, String id) => Biodata(
        id: id,
        nama: json['nama'],
        jenisKelamin: json['jenis_kelamin'],
        alamat: json['alamat'],
      );

  Map<String, dynamic> toJson() => {
        'nama': nama,
        'jenis_kelamin': jenisKelamin,
        'alamat': alamat,
      };
}
