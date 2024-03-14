import 'dart:convert';

List<Festivity> festivityFromJson(String str) => List<Festivity>.from(json.decode(str).map((x) => Festivity.fromJson(x)));

String festivityToJson(List<Festivity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Festivity {
    final int? id;
    final String nombre;
    final String descripcion;
    final String imgUrl;
    final int? dia;
    final int? mes;

    Festivity({
        this.id,
        required this.nombre,
        required this.descripcion,
        required this.imgUrl,
        required this.dia,
        required this.mes,
    });

    factory Festivity.fromJson(Map<String, dynamic> json) => Festivity(
        id: json["id"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        imgUrl: json["imgUrl"],
        dia: json["dia"],
        mes: json["mes"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "descripcion": descripcion,
        "imgUrl": imgUrl,
        "dia": dia,
        "mes": mes,
    };
}
