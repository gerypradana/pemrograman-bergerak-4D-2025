import 'package:flutter/material.dart';
import '../models/biodata.dart';
import '../services/api_service.dart';

class EditAlamatOnly extends StatefulWidget {
  final Biodata biodata;
  final Function() onUpdated;

  const EditAlamatOnly({
    super.key,
    required this.biodata,
    required this.onUpdated,
  });

  @override
  State<EditAlamatOnly> createState() => _EditAlamatOnlyState();
}

class _EditAlamatOnlyState extends State<EditAlamatOnly> {
  final _alamatController = TextEditingController();
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _alamatController.text = widget.biodata.alamat;
  }

  void _resetForm() {
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
          const Text('Edit Alamat',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              )),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.red),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      content: SizedBox(
        height: 80,
        child: Column(
          children: [
            TextField(
              controller: _alamatController,
              decoration: InputDecoration(
                labelText: 'Alamat',
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
            ),
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
            await apiService.patchAlamatBiodata(
              widget.biodata.id,
              _alamatController.text,
            );
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
}
