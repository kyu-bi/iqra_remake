import 'package:flutter/material.dart';
import 'package:iqra_app/modules/detailhijaiyah/controller/detail_huruf_controller.dart';
import 'package:iqra_app/data/models/detailhijaiyah.dart' as detail;
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';

class DetailHuruf extends StatelessWidget {
  final int id;
  DetailHuruf({required this.id});
  final player = AudioPlayer();
  Future<void> playAudio(String url) async {
    await player.play(UrlSource(url));
  }

  List<Widget> harkats = [];
  List<detail.Harkat>? harkat;
  DetailHijaiyahController detailHijaiyahC = DetailHijaiyahController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Huruf"),
      ),
      body: ChangeNotifierProvider(
        create: (context) => DetailHijaiyahController(),
        child: FutureBuilder<detail.DetailHijaiyah>(
          future: detailHijaiyahC.getDetailHijaiyah(id.toString()),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!snapshot.hasData) {
              return Center(
                child: Text("Data Kosong"),
              );
            }
            detail.DetailHijaiyah detailHijaiyah = snapshot.data!;
            harkats = List.generate(
              snapshot.data?.harkats.length ?? 0,
              (index) {
                harkat = snapshot.data?.harkats;
                return Consumer<DetailHijaiyahController>(
                  builder: (context, harkatState, _) {
                    // print(harkat?[index].audio);
                    if (harkatState.selectedHarkatIndex == index) {
                      return Column(
                        children: [
                          Text(
                            "${harkat?[index].tulisanArab}",
                            style: TextStyle(
                              fontSize: 50,
                            ),
                            textAlign: TextAlign.end,
                          ),
                          SizedBox(height: 20),
                          // Container(
                          //   decoration: BoxDecoration(
                          //       color: Colors.amber,
                          //       borderRadius: BorderRadius.circular(15)),
                          //   width: 80,
                          //   height: 50,
                          //   child: Center(
                          //     child: Text(
                          //       "${harkat?[index].tulisanLatin}",
                          //       style: TextStyle(fontSize: 20),
                          //     ),
                          //   ),
                          // ),
                          // ElevatedButton(
                          //     onPressed: () {
                          //       playAudio(
                          //           "https://9172-103-190-47-56.ngrok-free.app${harkat?[index].audio}");
                          //       print(harkat?[index].audio);
                          //     },
                          //     child: Text("Play")),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              Provider.of<DetailHijaiyahController>(
                                context,
                                listen: false,
                              ).selectHarkat(index);
                              // print(index);
                            },
                            child: Text("${harkat?[index].harkat}"),
                          ),
                        ],
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.only(top: 175),
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Provider.of<DetailHijaiyahController>(
                                context,
                                listen: false,
                              ).selectHarkat(index);
                              // print(index);
                            },
                            child: Text("${harkat?[index].harkat}"),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );

            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: harkats,
                  ),
                  SizedBox(height: 30),

                  Text(
                    "Cara Pengucapan :",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "${detailHijaiyah.pengucapan}",
                    textAlign: TextAlign.center,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        playAudio("assets/a.wav");
                      },
                      child: Text("Play")),
                  SizedBox(height: 20),
                  Text("Contoh Pengucapan :"),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.play_circle_outline_outlined),
                    iconSize: 80,
                  )
                  // Text("${harkat?[index].tulisanArab}"),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
