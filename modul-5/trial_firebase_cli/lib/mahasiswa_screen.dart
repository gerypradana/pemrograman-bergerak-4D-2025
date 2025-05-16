import 'package:flutter/material.dart';
import 'firebase_crud/list_mhs_firebase.dart';
import 'mysql_crud/list_mhs_mysql.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // latar belakang putih
      appBar: AppBar(
        backgroundColor: Colors.blue, // AppBar biru
        title: const Text(
          "firebase & mysql",
          style: TextStyle(color: Colors.yellow), // teks AppBar kuning
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Teks "Pilih Backend"
            RichText(
              text: const TextSpan(
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: 'Pilih ',
                    style: TextStyle(color: Colors.blue),
                  ),
                  TextSpan(
                    text: 'mysql / firebase :',
                    style: TextStyle(color: Colors.amber),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // Tombol Firebase
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 25, 145, 236), // tombol kuning
                foregroundColor: const Color.fromARGB(255, 255, 255, 255), // teks biru
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const ListMhsFirebase()));
              },
              child: const Text(
                "Gunakan Firebase Firestore",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 20),

            // Tombol MySQL
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 254, 175, 28), // tombol kuning
                foregroundColor: const Color.fromARGB(255, 236, 236, 236), // teks biru
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const ListMhsMySQL()));
              },
              child: const Text(
                "Gunakan MySQL REST API",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

