import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'add_mhs_mysql.dart';
import 'edit_mhs_mysql.dart';

class ListMhsMySQL extends StatefulWidget {
  const ListMhsMySQL({super.key});

  @override
  State<ListMhsMySQL> createState() => _ListMhsMySQLState();
}

class _ListMhsMySQLState extends State<ListMhsMySQL> {
  List<dynamic> mahasiswa = [];

  Future<void> getData() async {
    final response = await http.get(Uri.parse('http://192.168.100.80/mhs_API/get.php'));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      setState(() {
        mahasiswa = body['data'];
      });
    }
  }

  Future<void> deleteData(String nim) async {
    final response = await http.post(
      Uri.parse('http://192.168.100.80/mhs_API/delete.php'),
      body: {'nim': nim},
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data berhasil dihapus')),
      );
      getData();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal menghapus data')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
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
                text: 'mysql',
                style: TextStyle(color: Colors.orange, fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: mahasiswa.isEmpty
          ? const Center(child: Text('Belum ada data mahasiswa'))
          : ListView.builder(
              itemCount: mahasiswa.length,
              itemBuilder: (context, index) {
                final mhs = mahasiswa[index];
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
                                      text: mhs['nim'],
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
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                  children: [
                                    TextSpan(
                                      text: mhs['nama'],
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
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                  children: [
                                    TextSpan(
                                      text: mhs['address'],
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
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => EditMySQLDialog(data: mhs),
                                  ),
                                ).then((_) => getData());
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => deleteData(mhs['nim']),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 74, 135, 240),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddMysql()),
          ).then((_) => getData());
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
