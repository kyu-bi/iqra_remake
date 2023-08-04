import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:audioplayers/audioplayers.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:convert';
import 'package:iqra_app/data/models/detailhijaiyah.dart' as detail;

class DetailHijaiyahController extends ChangeNotifier {
  int selectedHarkatIndex = 0; // Initialize with -1
  final AudioPlayer player = AudioPlayer();

  void selectHarkat(int index) {
    selectedHarkatIndex = index;
    notifyListeners();
  }

  Future<detail.DetailHijaiyah> getDetailHijaiyah(String id) async {
    Uri url = Uri.parse(
        "https://cedb-2400-9800-8c3-575a-7932-d54e-88b6-b217.ngrok-free.app/hijaiyah/$id");
    var res = await http.get(url);
    Map<String, dynamic> data =
        (json.decode(res.body) as Map<String, dynamic>)["data"];
    return detail.DetailHijaiyah.fromJson(data);
  }

  Future<void> playAudio(String url) async {
    final audioSource = LockCachingAudioSource(Uri.parse(url));
    await player.setAudioSource(audioSource);
    await player.play();
  }
}
