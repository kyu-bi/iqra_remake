// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iqra_app/modules/detailhijaiyah/controller/detail_huruf_controller.dart';
import 'package:iqra_app/data/models/detailhijaiyah.dart' as detail;

class DetailHuruf extends StatelessWidget {
  int id;
  DetailHuruf({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Huruf"),
      ),
      body: ChangeNotifierProvider(
        create: (context) => DetailHijaiyahController(),
        child: Consumer<DetailHijaiyahController>(
          builder: (context, detailHijaiyahC, _) {
            return FutureBuilder<detail.DetailHijaiyah>(
              future: detailHijaiyahC.getDetailHijaiyah(id.toString()),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!snapshot.hasData) {
                  return const Center(
                    child: Text("Data Kosong"),
                  );
                }
                detail.DetailHijaiyah detailHijaiyah = snapshot.data!;
                List<detail.Harkat> harkats = detailHijaiyah.harkats;

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20),
                      if (detailHijaiyahC.selectedHarkatIndex != -1)
                        Column(
                          children: [
                            Text(
                              "${harkats[detailHijaiyahC.selectedHarkatIndex].tulisan_arab}",
                              style: const TextStyle(fontSize: 50),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "${harkats[detailHijaiyahC.selectedHarkatIndex].tulisan_latin}",
                              style: const TextStyle(fontSize: 35),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: harkats.asMap().entries.map((entry) {
                          int index = entry.key;
                          detail.Harkat harkat = entry.value;

                          return Column(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  detailHijaiyahC.selectHarkat(index);
                                  detailHijaiyahC.playAudio(harkat.audio);
                                },
                                child: Text("${harkat.harkat}"),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Cara Pengucapan:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "${detailHijaiyah.pengucapan}",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Contoh Pengucapan:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      IconButton(
                        onPressed: () {
                          detailHijaiyahC.playAudio(
                              "https://cedb-2400-9800-8c3-575a-7932-d54e-88b6-b217.ngrok-free.app${harkats[detailHijaiyahC.selectedHarkatIndex].audio}");
                          print(
                              "https://cedb-2400-9800-8c3-575a-7932-d54e-88b6-b217.ngrok-free.app${harkats[detailHijaiyahC.selectedHarkatIndex].audio}");
                        },
                        icon: const Icon(Icons.play_circle),
                        iconSize: 80,
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
