import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'add_mhs_firebase.dart';
import 'edit_mhs_firebase.dart';

class ListMhsFirebase extends StatefulWidget {
  const ListMhsFirebase({super.key});

  @override
  State<ListMhsFirebase> createState() => _ListMhsFirebaseState();
}

class _ListMhsFirebaseState extends State<ListMhsFirebase> {
  final CollectionReference _mahasiswaRef =
      FirebaseFirestore.instance.collection('mahasiswa');

  Future<void> _deleteData(String docId) async {
    try {
      await _mahasiswaRef.doc(docId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data berhasil dihapus')),
      );
    } catch (e) {
      debugPrint('Gagal menghapus data: $e');
    }
  }

  void _editData(DocumentSnapshot doc) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => EditFirestorePage(
        docId: doc.id,
        data: doc.data() as Map<String, dynamic>,
      ),
    ),
  ).then((_) {
    setState(() {}); // refresh setelah kembali
  });
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
                text: 'mahasiswa ',
                style: TextStyle(color: Colors.blue, fontSize: 28, fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: 'firebase',
                style: TextStyle(color: Colors.orange, fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _mahasiswaRef.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final dataList = snapshot.data!.docs;

          if (dataList.isEmpty) {
            return const Center(child: Text('Belum ada data mahasiswa'));
          }

          return ListView.builder(
            itemCount: dataList.length,
            itemBuilder: (context, index) {
              final doc = dataList[index];

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
                                text: 'NIM : ',
                                style: const TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                                children: [
                                  TextSpan(
                                    text: doc['nim'].toString(),
                                    style: const TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 7),
                            RichText(
                              text: TextSpan(
                                text: 'Nama : ',
                                style: const TextStyle(
                                    color:Colors.orange,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                                children: [
                                  TextSpan(
                                    text: doc['nama'].toString(),
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
                                    color:Colors.orange,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                                children: [
                                  TextSpan(
                                    text: doc['address'].toString(),
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
                            onPressed: () => _editData(doc),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteData(doc.id),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 74, 135, 240),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddFirestore()),
          ).then((_) {
            setState(() {}); // refresh setelah tambah data
          });
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
