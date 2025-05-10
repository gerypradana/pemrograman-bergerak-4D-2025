import 'package:flutter/material.dart';
import '../models/biodata.dart';
import '../services/api_service.dart';

class TambahBiodataScreen extends StatefulWidget {
  const TambahBiodataScreen({super.key});

  @override
  State<TambahBiodataScreen> createState() => _TambahBiodataScreenState();
}

class _TambahBiodataScreenState extends State<TambahBiodataScreen> {
  final _namaController = TextEditingController();
  final _alamatController = TextEditingController();
  String? _selectedGender;
  final ApiService apiService = ApiService();

  Future<void> _simpanBiodata() async {
    if (_namaController.text.isEmpty ||
        _alamatController.text.isEmpty ||
        _selectedGender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Semua field harus diisi')),
      );
      return;
    }

    final newData = Biodata(
      id: '',
      nama: _namaController.text,
      jenisKelamin: _selectedGender!,
      alamat: _alamatController.text,
    );
    await apiService.addBiodata(newData);
    Navigator.pop(context, true);
  }

  void _resetForm() {
    _namaController.clear();
    _alamatController.clear();
    setState(() {
      _selectedGender = null;
    });
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: const Text('Masukkan jenis kelamin'),
          value: _selectedGender,
          isExpanded: true,
          items: const [
            DropdownMenuItem(value: 'Laki - Laki', child: Text('Laki - Laki')),
            DropdownMenuItem(value: 'Perempuan', child: Text('Perempuan')),
          ],
          onChanged: (value) {
            setState(() {
              _selectedGender = value;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 251, 251, 251),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Tambah',
                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: 'Biodata',
                style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel("Nama"),
            const SizedBox(height: 8),
            _buildTextField(_namaController, "Masukkan nama"),
            const SizedBox(height: 20),
            _buildLabel("Jenis Kelamin"),
            const SizedBox(height: 8),
            _buildDropdown(),
            const SizedBox(height: 20),
            _buildLabel("Alamat"),
            const SizedBox(height: 8),
            _buildTextField(_alamatController, "Masukkan alamat"),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _resetForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 237, 84, 7),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Reset',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _simpanBiodata,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 2, 155, 158),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Tambah',
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
