import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditFirestorePage extends StatefulWidget {
  final String docId;
  final Map data;

  EditFirestorePage({required this.docId, required this.data});

  @override
  _EditFirestorePageState createState() => _EditFirestorePageState();
}

class _EditFirestorePageState extends State<EditFirestorePage> {
  late TextEditingController _namaController;
  late TextEditingController _nimController;
  late TextEditingController _alamatController;

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.data['nama']);
    _nimController = TextEditingController(text: widget.data['nim'].toString());
    _alamatController = TextEditingController(text: widget.data['address']);
  }

  void updateData() async {
    await FirebaseFirestore.instance.collection('mahasiswa').doc(widget.docId).update({
      'nama': _namaController.text,
      'nim': _nimController.text,
      'address': _alamatController.text,
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 89, 89, 89),
      body: Center(
        child: Container(
          width: 320,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header: Title & Close Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Edit Mahasiswa",
                    style: TextStyle(
                      color: Color(0xFF1A3A6E),
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      "×",
                      style: TextStyle(
                        color: Color(0xFFD12A3A),
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),

             
              buildLabel("Nim", Color(0xFF1A3A6E)),
              
              buildTextField(_nimController, enabled:false),

              SizedBox(height: 1),

              // NIM Field (dianggap sebagai Jenis Kelamin di label Anda)
              buildLabel("Nama", Color(0xFFD17F0A)),
              buildTextField(_namaController),

              SizedBox(height: 12),

              // Alamat Field
              buildLabel("Alamat",Color(0xFFD17F0A)),
              buildTextField(_alamatController),

              SizedBox(height: 20),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      _namaController.clear();
                      _nimController.clear();
                      _alamatController.clear();
                    },
                    icon: Icon(Icons.refresh, color: Color(0xFFD1A900), size: 18),
                    label: Text(
                      "Reset",
                      style: TextStyle(
                        color: Color(0xFFD1A900),
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      minimumSize: Size(70, 30),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: updateData,
                    icon: Icon(Icons.save, size: 18),
                    label: Text(
                      "Simpan",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 165, 178, 199),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      minimumSize: Size(90, 36),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method for label
  Widget buildLabel(String text, Color color) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }

  // Helper method for TextField
  Widget buildTextField(TextEditingController controller, {bool enabled = true}) {
  return SizedBox(
    height: 42,
    child: TextField(
      controller: controller,
      enabled: enabled,
      style: TextStyle(color: Color(0xFF1A3A6E), fontSize: 14),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Color(0xFF1A3A6E)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Color(0xFF1A3A6E)),
        ),
        isDense: true,
      ),
    ),
  );
}

}
