import 'package:flutter/material.dart';
import 'firebase_services.dart';

class AddFirestore extends StatefulWidget {
  const AddFirestore({super.key});

  @override
  State<AddFirestore> createState() => _AddFirestoreState();
}

class _AddFirestoreState extends State<AddFirestore> {
  final _nimController = TextEditingController();
  final _namaController = TextEditingController();
  final _alamatController = TextEditingController();
  final FirebaseService service = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text.rich(
          TextSpan(
            children: [
              TextSpan(text: 'Tambah', style: TextStyle(color: Colors.blue)),
              TextSpan(text: 'Mahasiswa', style: TextStyle(color: Colors.orange)),
            ],
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("NIM", style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              controller: _nimController,
              decoration: const InputDecoration(
                hintText: "Masukkan nim",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text("Nama", style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              controller: _namaController,
              decoration: const InputDecoration(
                hintText: "Masukkan Nama",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text("Alamat", style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              controller: _alamatController,
              decoration: const InputDecoration(
                hintText: "Masukkan Alamat",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _nimController.clear();
                      _namaController.clear();
                      _alamatController.clear();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text("Reset"),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final nim = _nimController.text.trim();
                      final nama = _namaController.text.trim();
                      final alamat = _alamatController.text.trim();

                      if (nim.isNotEmpty && nama.isNotEmpty && alamat.isNotEmpty) {
                        service.addMahasiswa(nim, nama, alamat).then((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Data berhasil ditambahkan")),
                          );
                          Navigator.pop(context);
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Semua field harus diisi")),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 37, 185, 167), 
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text("Simpan"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
