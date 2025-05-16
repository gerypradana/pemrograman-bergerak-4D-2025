import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final CollectionReference mahasiswa = FirebaseFirestore.instance.collection('mahasiswa');

  Future<void> addMahasiswa(String nim, String nama, String address) {
    return mahasiswa.add({
      'nim': nim,
      'nama': nama,
      'address': address,
    });
  }

  Future<void> updateMahasiswa(String docId, String nim, String nama, String address) {
    return mahasiswa.doc(docId).update({
      'nim': nim,
      'nama': nama,
      'address': address,
    });
  }

  Future<void> deleteMahasiswa(String docId) {
    return mahasiswa.doc(docId).delete();
  }
}
