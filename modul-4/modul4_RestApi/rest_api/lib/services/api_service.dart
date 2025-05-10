import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/biodata.dart';

class ApiService {
  final String baseUrl =
      'https://futterapi-default-rtdb.firebaseio.com/Biodata';

  Future<List<Biodata>> fetchData() async {
    final response = await http.get(Uri.parse('$baseUrl.json'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<Biodata> loaded = [];
      jsonData?.forEach((id, data) {
        loaded.add(Biodata.fromJson(data, id));
      });
      return loaded;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> addBiodata(Biodata newBiodata) async {
    await http.post(
      Uri.parse('$baseUrl.json'),
      body: json.encode(newBiodata.toJson()),
    );
  }

  Future<void> updateBiodata(Biodata biodata) async {
    await http.put(
      Uri.parse('$baseUrl/${biodata.id}.json'),
      body: json.encode(biodata.toJson()),
    );
  }

  Future<void> patchAlamatBiodata(String id, String alamatBaru) async {
  await http.patch(
    Uri.parse('$baseUrl/$id.json'),
    body: json.encode({'alamat': alamatBaru}),
  );
  }


  Future<void> deleteBiodata(String id) async {
    await http.delete(Uri.parse('$baseUrl/$id.json'));
  }
}