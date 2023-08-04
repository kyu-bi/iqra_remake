import 'dart:convert';

DetailHijaiyah detailHijaiyahFromJson(String str) =>
    DetailHijaiyah.fromJson(json.decode(str));

String detailHijaiyahToJson(DetailHijaiyah data) => json.encode(data.toJson());

class DetailHijaiyah {
  int id;
  String huruf;
  String tulisan_latin;
  String pengucapan;
  DateTime createdAt;
  DateTime updatedAt;
  List<Harkat> harkats;

  DetailHijaiyah({
    required this.id,
    required this.huruf,
    required this.tulisan_latin,
    required this.pengucapan,
    required this.createdAt,
    required this.updatedAt,
    required this.harkats,
  });

  factory DetailHijaiyah.fromJson(Map<String, dynamic> json) => DetailHijaiyah(
        id: json["id"],
        huruf: json["huruf"],
        tulisan_latin: json["tulisan_latin"],
        pengucapan: json["pengucapan"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        harkats:
            List<Harkat>.from(json["harkats"].map((x) => Harkat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "huruf": huruf,
        "tulisan_latin": tulisan_latin,
        "pengucapan": pengucapan,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "harkats": List<dynamic>.from(harkats.map((x) => x.toJson())),
      };
}

class Harkat {
  int id;
  int huruf_id;
  String harkat;
  String tulisan_arab;
  String tulisan_latin;
  String audio;
  DateTime createdAt;
  DateTime updatedAt;

  Harkat({
    required this.id,
    required this.huruf_id,
    required this.harkat,
    required this.tulisan_arab,
    required this.tulisan_latin,
    required this.audio,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Harkat.fromJson(Map<String, dynamic> json) => Harkat(
        id: json["id"],
        huruf_id: json["huruf_id"],
        harkat: json["harkat"],
        tulisan_arab: json["tulisan_arab"],
        tulisan_latin: json["tulisan_latin"],
        audio: json["audio"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "huruf_id": huruf_id,
        "harkat": harkat,
        "tulisan_arab": tulisan_arab,
        "tulisan_latin": tulisan_latin,
        "audio": audio,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
