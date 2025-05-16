import 'package:flutter/material.dart';
import 'mysql_services.dart';

class AddMysql extends StatefulWidget {
  @override
  State<AddMysql> createState() => _AddMysqlState();
}

class _AddMysqlState extends State<AddMysql> {
  final _nimController = TextEditingController();
  final _namaController = TextEditingController();
  final _addressController = TextEditingController();
  final MysqlService service = MysqlService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
            children: [
              TextSpan(
                text: "Tambah",
                style: TextStyle(color: Colors.blue[500]),
              ),
              TextSpan(
                text: "Mahasiswa",
                style: TextStyle(color: Colors.orange[600]),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildTextField(
              controller: _nimController,
              label: "NIM",
              hint: "Masukkan nim",
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _namaController,
              label: "Nama",
              hint: "Masukkan nama",
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _addressController,
              label: "Alamat",
              hint: "Masukkan alamat",
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _nimController.clear();
                      _namaController.clear();
                      _addressController.clear();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[600],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      foregroundColor: Colors.black,
                      elevation: 0,
                    ),
                    child: const Text("Reset"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      service
                          .addMahasiswa(
                            _nimController.text,
                            _namaController.text,
                            _addressController.text,
                          )
                          .then((success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              success
                                  ? "Data berhasil ditambahkan"
                                  : "Gagal menambahkan data",
                            ),
                          ),
                        );
                        if (success) Navigator.pop(context);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      foregroundColor: Colors.black,
                      elevation: 0,
                    ),
                    child: const Text("Simpan"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[400]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Colors.blue.shade500, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
      style: const TextStyle(color: Colors.black),
    );
  }
}
