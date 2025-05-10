import 'package:flutter/material.dart';
import '../models/biodata.dart';
import '../services/api_service.dart';

class EditAllBiodata extends StatefulWidget {
  final Biodata existing;
  final Function() onUpdated;

  const EditAllBiodata({
    super.key,
    required this.existing,
    required this.onUpdated,
  });

  @override
  State<EditAllBiodata> createState() => _EditAllBiodataState();
}

class _EditAllBiodataState extends State<EditAllBiodata> {
  final _namaController = TextEditingController();
  final _jkController = TextEditingController();
  final _alamatController = TextEditingController();
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _namaController.text = widget.existing.nama;
    _jkController.text = widget.existing.jenisKelamin;
    _alamatController.text = widget.existing.alamat;
  }

  void _resetForm() {
    _namaController.clear();
    _jkController.clear();
    _alamatController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      titlePadding: const EdgeInsets.fromLTRB(24, 24, 16, 0),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Edit All Biodata',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.red),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            _buildTextField(_namaController, 'Nama'),
            const SizedBox(height: 10),
            _buildTextField(_jkController, 'Jenis Kelamin'),
            const SizedBox(height: 10),
            _buildTextField(_alamatController, 'Alamat'),
          ],
        ),
      ),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      actions: [
        TextButton.icon(
          onPressed: _resetForm,
          icon: const Icon(Icons.refresh, color: Colors.amber),
          label: const Text('Reset', style: TextStyle(color: Colors.amber)),
        ),
        ElevatedButton.icon(
          onPressed: () async {
            final updated = Biodata(
              id: widget.existing.id,
              nama: _namaController.text,
              jenisKelamin: _jkController.text,
              alamat: _alamatController.text,
            );
            await apiService.updateBiodata(updated);
            widget.onUpdated();
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.save),
          label: const Text('Simpan'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.blue),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.amber),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
