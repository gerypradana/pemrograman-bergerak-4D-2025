import 'dart:convert';
import 'package:http/http.dart' as http;

class MysqlService {
  final String baseUrl = "http://192.168.100.80/mhs_API"; // ganti dengan IP kamu

  Future<bool> addMahasiswa(String nim, String nama, String address) async {
    final response = await http.post(
      Uri.parse("$baseUrl/post.php"),
      body: {
        'nim': nim,
        'nama': nama,
        'address': address,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['success'] == true;
    } else {
      return false;
    }
  }
}
