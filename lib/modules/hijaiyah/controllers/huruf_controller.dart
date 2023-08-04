import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:iqra_app/data/models/hijaiyah.dart';

class HijaiyahController extends ChangeNotifier {
  List<Hijaiyah> allItem = [];

  Future<List<Hijaiyah>> getAllItem() async {
    try {
      var response = await http.get(Uri.parse(
          "https://cedb-2400-9800-8c3-575a-7932-d54e-88b6-b217.ngrok-free.app/hijaiyah"));
      List data = (json.decode(response.body) as Map<String, dynamic>)["data"];
      data.forEach((element) {
        allItem.add(Hijaiyah.fromJson(element));
      });
      return allItem; // Mengembalikan nilai allItem setelah data dimuat
    } catch (e) {
      print("Terjadi kesalahan");
      print(e);
      return []; // Mengembalikan list kosong jika terjadi kesalahan
    }
  }
}
