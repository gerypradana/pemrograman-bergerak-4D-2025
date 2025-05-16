import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditMySQLDialog extends StatefulWidget {
  final Map data;

  const EditMySQLDialog({Key? key, required this.data}) : super(key: key);

  @override
  State<EditMySQLDialog> createState() => _EditMySQLDialogState();
}

class _EditMySQLDialogState extends State<EditMySQLDialog> {
  late TextEditingController _namaController;
  late TextEditingController _nimController;
  late TextEditingController _alamatController;

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.data['nama']);
    _nimController = TextEditingController(text: widget.data['nim']);
    _alamatController = TextEditingController(text: widget.data['address']);
  }

  Future<void> _updateData() async {
    final response = await http.post(
      Uri.parse('http://192.168.100.80/mhs_API/put.php'),
      body: {
        'nim': _nimController.text,
        'nama': _namaController.text,
        'address': _alamatController.text,
      },
    );

    if (response.statusCode == 200) {
      Navigator.of(context).pop(true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal update data')),
      );
    }
  }

  void _resetFields() {
    _namaController.clear();
    _nimController.clear();
    _alamatController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color.fromARGB(0, 229, 47, 47),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Edit Mahasiswa",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A3A6E),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Color(0xFFD12A3A)),
                  onPressed: () => Navigator.of(context).pop(),
                  splashRadius: 20,
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Nim (non-editable)
            TextField(
              controller: _nimController,
              enabled: false,
              style: const TextStyle(color: Color(0xFF1A3A6E)),
              decoration: InputDecoration(
                labelText: 'Nim',
                labelStyle: const TextStyle(
                  color: Color(0xFF1A3A6E),
                  fontWeight: FontWeight.w500,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
                ),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            const SizedBox(height: 12),

            // Nama
            TextField(
              controller: _namaController,
              style: const TextStyle(color: Color(0xFF1A3A6E)),
              decoration: InputDecoration(
                labelText: 'Nama',
                labelStyle: const TextStyle(
                  color: Color(0xFFD17A00),
                  fontWeight: FontWeight.w600,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF6B7280)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF6B7280)),
                ),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            const SizedBox(height: 12),

            // Alamat
            TextField(
              controller: _alamatController,
              style: const TextStyle(color: Color(0xFF1A3A6E)),
              decoration: InputDecoration(
                labelText: 'Alamat',
                labelStyle: const TextStyle(
                  color: Color(0xFFD17A00),
                  fontWeight: FontWeight.w600,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF6B7280)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF6B7280)),
                ),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            const SizedBox(height: 20),

            // Button Row: Reset & Simpan
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: _resetFields,
                  icon: const Icon(Icons.refresh, color: Color(0xFFD1A900)),
                  label: const Text(
                    "Reset",
                    style: TextStyle(
                      color: Color(0xFFD1A900),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                    minimumSize: const Size(70, 30),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    alignment: Alignment.centerLeft,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _updateData,
                  icon: const Icon(Icons.save, color: Color(0xFF5B5E8B)),
                  label: const Text(
                    "Simpan",
                    style: TextStyle(color: Color(0xFF5B5E8B)),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB0B6D6),
                    foregroundColor: const Color(0xFF5B5E8B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    minimumSize: const Size(90, 36),
                    elevation: 0,
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
