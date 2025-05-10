import 'package:flutter/material.dart';
import '../models/biodata.dart';
import '../services/api_service.dart';
import 'tambah_biodata.dart';
import 'edit_all_biodata.dart';
import 'edit_alamat_only.dart';

class BiodataScreen extends StatefulWidget {
  const BiodataScreen({super.key});

  @override
  State<BiodataScreen> createState() => _BiodataScreenState();
}

class _BiodataScreenState extends State<BiodataScreen> {
  final ApiService apiService = ApiService();
  List<Biodata> _biodataList = [];

  @override
  void initState() {
    super.initState();
    _loadBiodata();
  }

  Future<void> _loadBiodata() async {
    try {
      final data = await apiService.fetchData();
      setState(() {
        _biodataList = data;
      });
    } catch (e) {
      debugPrint('Error fetching data: $e');
    }
  }

    void _showForm({required Biodata existing}) {
  showDialog(
    context: context,
    builder: (_) => EditAllBiodata(
      existing: existing,
      onUpdated: _loadBiodata,
    ),
  );
}

    void _showEditOptions(Biodata biodata) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    'Pilih Opsi Edit',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Ingin mengedit semua biodata atau hanya alamat?',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _showForm(existing: biodata);
                    },
                    icon: const Icon(Icons.edit, color: Colors.white),
                    label: const Text('Edit Semua Biodata'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _showAlamatOnlyForm(biodata);
                    },
                    icon: const Icon(Icons.location_on, color: Colors.white),
                    label: const Text('Edit Alamat Saja'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.grey),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAlamatOnlyForm(Biodata biodata) {
  showDialog(
    context: context,
    builder: (_) => EditAlamatOnly(
      biodata: biodata,
      onUpdated: _loadBiodata,
    ),
  );
}

  Future<void> _deleteBiodata(String id) async {
    await apiService.deleteBiodata(id);
    _loadBiodata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 197, 231, 247),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Biodata',
                style: TextStyle(color: Colors.blue, fontSize:28,fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: 'Penduduk',
                style: TextStyle(color: Colors.orange, fontSize: 28,fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: _biodataList.isEmpty
          ? const Center(child: Text('Belum ada data'))
          : ListView.builder(
              itemCount: _biodataList.length,
              itemBuilder: (ctx, i) {
                final biodata = _biodataList[i];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 71, 70, 70).withOpacity(0.7),
                          blurRadius: 6,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: 'Nama : ',
                                  style: const TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                  children: [
                                    TextSpan(
                                      text: biodata.nama,
                                      style: const TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 6),
                              RichText(
                                text: TextSpan(
                                  text: 'Jenis Kelamin : ',
                                  style: const TextStyle(
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                  children: [
                                    TextSpan(
                                      text: biodata.jenisKelamin,
                                      style: const TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 6),
                              RichText(
                                text: TextSpan(
                                  text: 'Alamat : ',
                                  style: const TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                  children: [
                                    TextSpan(
                                      text: biodata.alamat,
                                      style: const TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.orange),
                              onPressed: () => _showEditOptions(biodata),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.orange),
                              onPressed: () => _deleteBiodata(biodata.id),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 74, 135, 240),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const TambahBiodataScreen()),
          );
          if (result == true) {
            _loadBiodata();
          }
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
