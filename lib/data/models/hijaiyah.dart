import 'dart:convert';

Hijaiyah hijaiyahFromJson(String str) => Hijaiyah.fromJson(json.decode(str));

String hijaiyahToJson(Hijaiyah data) => json.encode(data.toJson());

class Hijaiyah {
    int id;
    String huruf;
    String tulisanLatin;
    String pengucapan;
    DateTime createdAt;
    DateTime updatedAt;

    Hijaiyah({
        required this.id,
        required this.huruf,
        required this.tulisanLatin,
        required this.pengucapan,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Hijaiyah.fromJson(Map<String, dynamic> json) => Hijaiyah(
        id: json["id"],
        huruf: json["huruf"],
        tulisanLatin: json["tulisan_latin"],
        pengucapan: json["pengucapan"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "huruf": huruf,
        "tulisan_latin": tulisanLatin,
        "pengucapan": pengucapan,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
